pipeline {
    agent any

    parameters {
        booleanParam(name: 'HEADLESS', defaultValue: true, description: 'Run browser in headless mode')
        string(name: 'BROWSER', defaultValue: 'chrome', description: 'Browser to use for tests')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ervaldez04/test-automation-project-robot-framework.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                script {
                    def headlessValue = params.HEADLESS ? "True" : "False"
                    sh "robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${headlessValue} TestSuite/"
                }
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
