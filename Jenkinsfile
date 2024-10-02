pipeline {
    agent any

    environment {
        REGISTRY = "docker.io/nbomasi" // e.g. docker.io/username
        IMAGE_NAME = "tooling-php-app"
        BRANCH_NAME = "${env.GIT_BRANCH}".replaceAll("origin/", "")
        DOCKER_CREDENTIALS_ID = 'docker-credential' // ID of Docker credentials in Jenkins
        TAG = "${BRANCH_NAME}-${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "Simulating Docker Build..."
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${TAG} ."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Running Test for the tooling site..."
                    // Ensure your tooling site is running, use curl to check the HTTP status code
                    //def responseCode = sh(script: "curl -o /dev/null -s -w '%{http_code}' http://16.171.6.232:80", returnStdout: true)
                    def responseCode = sh(script: "curl -o /dev/null -s -w '%{http_code}' http://localhost:80/health", returnStdout: true).trim()
                    if (responseCode != "200") {
                        error "Test failed: Tooling site returned HTTP status code ${responseCode}"
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        echo "Pushing image to Docker registry..."
                        sh "docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}"
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    echo "Cleaning up local Docker images..."
                    sh "docker rmi ${REGISTRY}/${IMAGE_NAME}:${TAG} || true"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
