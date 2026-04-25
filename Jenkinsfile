pipeline {
    agent any

    environment {
        // Define environment variables
        IMAGE_NAME = 'my-static-app'
        DOCKER_USER = 'hamsaediger'
        DOCKER_PASS = 'Hamsa@1466'
        DOCKER_REGISTRY = 'hamsaediger'
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
                    // Build the Docker image using sh command
                    sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_ID} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Pushing Docker image to registry..."
                    // Login to Docker Hub using the credentials provided
                    sh "echo '${DOCKER_PASS}' | docker login -u '${DOCKER_USER}' --password-stdin"
                    
                    // Push the image tagged with the build ID
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_ID}"
                    
                    // Tag and push 'latest'
                    sh "docker tag ${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_ID} ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
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
