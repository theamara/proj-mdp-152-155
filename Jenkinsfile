pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'project-1', url: 'https://github.com/theamara/proj-mdp-152-155.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-java-app .'
            }
        }

        stage('Run Container') {
            steps {
                // Stop and remove existing container if any
                sh 'docker rm -f my-java-container || true'
                // Run container in detached mode, map port 8080
                sh 'docker run -d -p 8080:8080 --name my-java-container my-java-app'
            }
        }
    }

    post {
        always {
            // Cleanup: stop and remove container after job ends
            sh 'docker rm -f my-java-container || true'
        }
    }
}

