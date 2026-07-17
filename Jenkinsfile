pipeline {
    agent any

    environment {
        DOCKER_TAG = "${env.BRANCH_NAME}"
        SAFE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}".replaceAll('/', '-')
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
                echo "🔥 BRANCH DETECTED: ${env.BRANCH_NAME}"
            }
        }

        stage('Setup Environment Config') {
            steps {
                script {

                    def actualBranch = env.BRANCH_NAME
                    echo "🧭 Actual Git branch: ${actualBranch}"

                    def config = [
                        development: [
                            SERVER_SSH: 'root@152.42.175.121',
                            DEPLOY_DIR: '/var/www/html/containerized-laravel-platform',
                            COMPOSE_FILE: 'docker-compose.yml',
                            ENV_CREDENTIALS : 'clp-dev-env',
                            SSH_CREDENTIALS : 'clp-dev-ssh',
                            KNOWN_HOSTS_FILE: 'clp-dev-known-hosts',
                            CONTAINER_NAME  : 'laravel-app',
                            DOCKER_FILE     : 'Dockerfile',
                            DOCKER_IMAGE    : 'dennamandela13/containerized-laravel-platform'
                        ]
                        // production: [
                        //     SERVER_SSH: 'ubuntu@47.xxx.xxx.xxx',
                        //     DEPLOY_DIR: '/var/www/html/containerized-laravel-platform',
                        //     COMPOSE_FILE: 'docker-compose.prod.yml',
                        //     ENV_CREDENTIALS : 'clp-prod-env',
                            // SSH_CREDENTIALS : 'clp-prod-ssh',
                            // KNOWN_HOSTS_FILE: 'clp-prod-known-hosts',
                            // CONTAINER_NAME  : 'laravel-app',
                            // DOCKER_FILE     : 'Dockerfile',
                            // DOCKER_IMAGE    : 'dennamandela/containerized-laravel-platform'
                        // ]
                    ]

                    def envType = (actualBranch == 'production') ? 'production' : 'development'

                    echo "DEBUG >> actualBranch: ${actualBranch}"
                    echo "DEBUG >> envType: ${envType}"

                    echo "✅ Environment selected: ${envType.toUpperCase()}"

                    if (!config.containsKey(envType)) {
                        error "❌ No configuration found for environment: ${envType}"
                    }

                    def selected = config[envType]
                    selected.each { key, value -> env."${key}" = value }

                    echo "🔧 Container Name: ${env.CONTAINER_NAME}"
                    echo "📍 Deploy Directory: ${env.DEPLOY_DIR}"
                }
            }
        }

        stage('Prepare Environment') {
            steps {
                withCredentials([file(credentialsId: "${ENV_CREDENTIALS}", variable: 'ENV_FILE')]) {
                    script {
                        sh '''
                            echo "🧩 Preparing .env for environment..."
                            rm -f .env || true
                            cp "$ENV_FILE" .env

                            if [ ! -s .env ]; then 
                                echo ".env file is empty or missing!"
                                exit 1
                            fi
                        '''
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${DOCKER_IMAGE}:${SAFE_TAG}"
                    dockerImage = docker.build("${DOCKER_IMAGE}:${SAFE_TAG}", "--no-cache -f ${DOCKER_FILE} .")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                        docker push ${DOCKER_IMAGE}:${SAFE_TAG}

                        TAG=$( [ "$BRANCH_NAME" = "production" ] && echo "latest" || echo "development" )

                        docker tag ${DOCKER_IMAGE}:${SAFE_TAG} ${DOCKER_IMAGE}:${TAG}
                        docker push ${DOCKER_IMAGE}:${TAG}
                    '''
                }
            }
        }

        stage('Manual Approval (Production Only)') {
            when {
                expression { env.BRANCH_NAME == 'production' }
            }
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input message: "⚠️ Approve deployment to PRODUCTION?", ok: "Deploy Now 🚀"
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    echo "🚀 Deploying image: ${DOCKER_IMAGE}:${SAFE_TAG} to ${env.BRANCH_NAME} server..."

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: env.SSH_CREDENTIALS,
                            keyFileVariable: 'SSH_KEY'
                        ),
                        usernamePassword(
                            credentialsId: 'dockerhub-creds',
                            usernameVariable: 'DOCKER_USER',
                            passwordVariable: 'DOCKER_PASS'
                        ),
                        file(
                            credentialsId: env.KNOWN_HOSTS_FILE,
                            variable: 'KNOWN_HOSTS_FILE'
                        )
                    ]) {

                        sh '''
                            set -e

                            mkdir -p ~/.ssh

                            cp "$KNOWN_HOSTS_FILE" ~/.ssh/known_hosts
                            chmod 644 ~/.ssh/known_hosts

                            echo "📦 Copying .env..."
                            scp -i "$SSH_KEY" .env ${SERVER_SSH}:${DEPLOY_DIR}/.env

                            ssh -i "$SSH_KEY" ${SERVER_SSH} "
                                set -e
                                cd ${DEPLOY_DIR}

                                export DOCKER_USER='${DOCKER_USER}'
                                export DOCKER_PASS='${DOCKER_PASS}'
                                export IMAGE='${DOCKER_IMAGE}:${SAFE_TAG}'

                                echo '${SAFE_TAG}' > LAST_RELEASE_CURRENT

                                echo \"\$DOCKER_PASS\" | docker login -u \"\$DOCKER_USER\" --password-stdin

                                docker compose -f ${COMPOSE_FILE} pull
                                docker compose -f ${COMPOSE_FILE} up -d --force-recreate --remove-orphans

                                echo 'Deployment completed.'
                            "
                        '''
                    }
                }
            }
        }
    }
}