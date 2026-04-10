pipeline {
    agent any

    environment {
        CI = "true"   // Flag to indicate Jenkins environment
    }

    parameters {
        booleanParam(
            name: 'HEADLESS', 
            defaultValue: true, 
            description: 'Run browser in headless mode'
        )
        string(
            name: 'BROWSER', 
            defaultValue: 'chrome', 
            description: 'Browser to use for tests'
        )
        choice(
            name: 'TEST_FOLDER',
            choices: ['TestSuite/PlaygroundBank', 'TestSuite/SwagLabs'],
            description: 'Select one test folder to run'
        )
        choice(
            name: 'INCLUDE_TAG',
            choices: ['none', 'Smoke', 'Regression', 'Performance', 'Sanity', 'Positive', 'Negative'],
            description: 'Select a tag to include (or none)'
        )
        choice(
            name: 'EXCLUDE_TAG',
            choices: ['none', 'Slow', 'Flaky', 'Deprecated'],
            description: 'Select a tag to exclude (or none)'
        )
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
                    def includeOption = params.INCLUDE_TAG != 'none' ? "--include ${params.INCLUDE_TAG}" : ""
                    def excludeOption = params.EXCLUDE_TAG != 'none' ? "--exclude ${params.EXCLUDE_TAG}" : ""
                    
                    bat "python -m robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${headlessValue} --outputdir results ${includeOption} ${excludeOption} ${params.TEST_FOLDER}"
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
