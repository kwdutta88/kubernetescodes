pipeline {
    agent any

    environment {
        // Define the 'app' variable at the pipeline level
        app = null
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {
                script {
                    // Assign the 'app' variable at the pipeline level
                    app = docker.build("krishdutta1177/test:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Test image') {
            steps {
                script {
                    // Use the 'app' variable
                    app.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        // Use the 'app' variable
                        app.push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }

        stage('Trigger ManifestUpdate') {
            steps {
                script {
                    echo "triggering updatemanifestjob"
                    // Use the 'app' variable
                    build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
                }
            }
        }
    }
}
