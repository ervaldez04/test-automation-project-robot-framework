pipeline {
    agent any

    parameters {
        booleanParam(name: 'HEADLESS', defaultValue: true, description: 'Run browser in headless mode')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ervaldez04/test-automation-project-robot-framework.git'
            }
        }

        stage('Install Dependencies') {
            when {
                branch 'main'
            }
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            when {
                branch 'main'
            }

            steps {
                sh "robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${params.HEADLESS} TestSuite/"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/output.xml', fingerprint: true
            publishHTML(target: [
                reportDir: '.',
                reportFiles: 'report.html, log.html',
                keepAll: true,
                reportName: 'Robot Framework Report'
            ])
        }
    }
}
