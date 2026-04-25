pipeline {
    agent any

    environment {
        // Define environment variables
        IMAGE_NAME = 'my-static-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Update with your Jenkins credentials ID
        DOCKER_REGISTRY = 'your-dockerhub-username'      // Update with your Docker Hub username
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image ${IMAGE_NAME}..."
                    // Build the Docker image
                    dockerImage = docker.build("${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Pushing Docker image to registry..."
                    // Login and push to registry using Jenkins credentials
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push()
                        // Optional: Push the 'latest' tag as well
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
            // Clean up the image locally after pushing to save space
            script {
                sh "docker rmi ${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_ID} || true"
            }
        }
        success {
            echo "Pipeline succeeded!"
        }
        failure {
            echo "Pipeline failed! Please check the logs."
        }
    }
}
