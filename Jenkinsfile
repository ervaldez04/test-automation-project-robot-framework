pipeline {
    agent any

    environment {
        CI = "true"   // Flag to indicate Jenkins environment
    }

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
                    def folders = params.TEST_FOLDERS.tokenize(',')
                    for (folder in folders) {
                        echo "▶ Running tests in TestSuite/${folder}"
                        bat "python -m robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${headlessValue} ---outputdir results/${folder.replaceAll('/', '_')} TestSuite/${folder}"
                    }
                }
            }
        }

        stage('Publish Results') {
            steps {
                script {
                    // Collect all Robot Framework output.xml files under results/
                    def xmlFiles = findFiles(glob: 'results/**/output.xml')
                    if (xmlFiles) {
                        def paths = xmlFiles.collect { it.path }.join(' ')
                        echo "Merging Robot outputs: ${paths}"
                        bat "python -m robot.rebot --merge --output results/output.xml --report results/report.html --log results/log.html ${paths}"
                    } else {
                        echo "⚠ No output.xml files found to merge"
                    }
                }
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
            archiveArtifacts artifacts: 'results/**/*.*', fingerprint: true
        }
    }
}
