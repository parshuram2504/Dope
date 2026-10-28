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
            docker.withRegistry('https://hub.docker.com/u/parshuram2504') {
                def image = docker.build("parshuram2504/dope:${env.BUILD_NUMBER}", "-f Docker/Dockerfile .")
                image.push()
                image.push('latest')
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