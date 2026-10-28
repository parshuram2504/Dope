pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/repository/docker/parshuram2504/dope') {
                        def dope = docker.build("parshuram2504/dope:${env.BUILD_NUMBER}")
                        dope.push()
                        dope.push("latest")
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}