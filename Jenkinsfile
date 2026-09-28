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
                    pip install --upgrade pip --retries 10 --timeout 60
                    pip install --retries 10 --timeout 60 -r backend/requirements.txt
                '''
            }
        }

        stage('Lint') {
            steps {
                sh '''
                    mkdir -p evidence/reports
                    . .venv/bin/activate
                    ruff check backend --output-format junit > evidence/reports/lint.xml
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
                    GIT_COMMIT_HASH=$(git log -n 1 --pretty=format:'%H')
                    . ./.env.example
                    mkdir -p evidence/artifacts
                    tar -czf evidence/artifacts/app-\${APP_VERSION}-\${BUILD_NUMBER}-\${GIT_COMMIT_HASH}.tar.gz --warning=no-file-changed *
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
