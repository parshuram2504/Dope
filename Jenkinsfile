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
            docker.withRegistry('https://hub.docker.com/repository/docker/parshuram2504/dope') {
                def dope = docker.build("dope:${env.BUILD_ID}")
                dope.push()
            }
        }
        
}