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
                    bat 'python -m pip install --upgrade pip'
                    bat 'pip install -r requirements.txt'
                    bat 'python --version'
            }
        }

        stage('Run Test Suite') {
            steps {
                script {
                    def headlessValue = params.HEADLESS ? "True" : "False"
                    bat "python -m robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${headlessValue} --outputdir results TestSuite/"
                }
            }
        }

        stage('Publish Results') {
            steps {
                publishHTML(target: [
                    reportName: 'Robot Framework Report',
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    keepAll: true,
                    alwaysLinkToLastBuild: true,
                    allowMissing: false
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/*.*', fingerprint: true
        }
    }
}
