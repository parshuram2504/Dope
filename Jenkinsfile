pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
    }
        stage('Build') {
            steps {
                sh 'echo "Building the docker image"'
                sh 'cd Docker'
                sh 'docker build -t Dope .'
                // Add your build commands here
            }
        }
        stage('Tag image') {
            steps {
                sh 'echo "Tagging the docker image"'
                sh 'docker tag Dope parshuram2504/dope:latest'
                sh 'docker push parshuram2504/dope:latest'
                // Add your tag commands here
            }
        }
}