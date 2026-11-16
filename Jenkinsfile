pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate Helm Chart') {
            steps {
                sh '''
                    case "$BUILD_NUMBER" in
                        ""|*[!0-9]*)
                            echo "BUILD_NUMBER must be numeric to create a SemVer chart version" >&2
                            exit 1
                            ;;
                    esac

                    helm lint helm-chart
                    helm template dope helm-chart >/dev/null
                    helm template dope helm-chart --set ingress.enabled=true >/dev/null
                '''
            }
        }

        stage('Package Helm Chart') {
            steps {
                script {
                    def chartVersion = "0.1.${env.BUILD_NUMBER}"
                    sh """
                        mkdir -p .helm-package
                        helm package helm-chart \\
                            --version '${chartVersion}' \\
                            --app-version '${env.BUILD_NUMBER}' \\
                            --destination .helm-package

                        chart_metadata=\$(helm show chart '.helm-package/dope-${chartVersion}.tgz')
                        if ! printf '%s\\n' "\$chart_metadata" | grep -Fxq 'version: ${chartVersion}' ||
                           ! printf '%s\\n' "\$chart_metadata" | grep -Fxq 'appVersion: "${env.BUILD_NUMBER}"'; then
                            echo "Packaged chart metadata does not match expected version ${chartVersion} and appVersion ${env.BUILD_NUMBER}" >&2
                            exit 1
                        fi

                        if ! helm template dope '.helm-package/dope-${chartVersion}.tgz' |
                            grep -Fq 'image: "parshuram2504/dope:${env.BUILD_NUMBER}"'; then
                            echo "Packaged chart does not render the image built for this Jenkins run" >&2
                            exit 1
                        fi
                    """
                    archiveArtifacts artifacts: ".helm-package/dope-${chartVersion}.tgz", fingerprint: true
                }
            }
        }

        stage('Build and Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'jenkins_docker') {
                        def image = docker.build("parshuram2504/dope:${env.BUILD_NUMBER}", "-f Docker/Dockerfile .")
                        image.push()
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