pipeline {
    agent any

    environment {
        IMAGE_NAME = "amara032/calculator-app"
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
    }

    triggers {
        pollSCM('* * * * *')  // Optional: check for changes every minute
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'project-3', url: 'https://github.com/theamara/proj-mdp-152-155.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

