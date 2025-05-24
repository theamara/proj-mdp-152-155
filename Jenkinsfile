pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'project-1', url: 'https://github.com/<your-github-username>/proj-mdp-152-155.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("calculator-app:latest")
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker rm -f calculator || true'
                sh 'docker run -d --name calculator -p 8080:8080 calculator-app:latest'
            }
        }
    }
}
