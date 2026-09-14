pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install dependencies') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install --upgrade pip
                    pip install -r backend/requirements.txt
                '''
            }
        }

        stage('Lint') {
            steps {
                sh '''
                    . .venv/bin/activate
                    ruff check backend
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    mkdir -p evidence/reports
                    . .venv/bin/activate
                    pytest backend/tests --junitxml=evidence/reports/tests.xml
                '''
            }
        }

        stage('Build artifact') {
            steps {
                sh '''
                    source .env.example
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
