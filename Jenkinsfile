pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Lint') {
            agent {
                docker {
                    image 'python:3.12-slim'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    pip install --retries 10 --timeout 60 ruff -r backend/requirements.txt
                    ruff check backend
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'python:3.12-slim'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    pip install --retries 10 --timeout 60 -r backend/requirements.txt pytest
                    mkdir -p evidence/reports
                    pytest backend/tests --junitxml=evidence/reports/tests.xml
                '''
            }
        }

        stage('Build artifact') {
            steps {
                sh '''
                    . ./.env.example
                    mkdir -p evidence/artifacts
                    tar -czf evidence/artifacts/app-${APP_VERSION}.tar.gz *
                '''
            }
        }
    }

    post {
        always {
            junit allowEmptyResults: true, testResults: 'evidence/reports/*.xml'
            archiveArtifacts(
                artifacts: 'evidence/artifacts/*.tar.gz,evidence/reports/*.xml',
                allowEmptyArchive: true,
                fingerprint: true
            )
        }
    }
}
