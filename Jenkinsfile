pipeline {
    agent any

    environment {
        CI = "true"   // Flag to indicate Jenkins environment
    }

    parameters {
        booleanParam(name: 'HEADLESS', defaultValue: true, description: 'Run browser in headless mode')
        string(name: 'BROWSER', defaultValue: 'chrome', description: 'Browser to use for tests')
        multiSelect(
            name: 'TEST_FOLDERS',
            choices: ['TestSuite/PlaygroundBank', 'TestSuite/SwagLabs'],
            description: 'Select one or more test folders to run'
        )

    stages {
        stage('Debug Webhook') {
            steps {
                echo "Action: ${env.action}"
                echo "Merged: ${env.merged}"
                echo "Branch: ${env.branch}"
            }
        }
        
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
                    bat "python -m robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${headlessValue} --outputdir results ${params.TEST_FOLDER}"
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
