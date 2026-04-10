pipeline {
    agent any

    environment {
        CI = "true"   // Flag to indicate Jenkins environment
    }

    parameters {
        booleanParam(name: 'HEADLESS', defaultValue: true, description: 'Run browser in headless mode')
        string(name: 'BROWSER', defaultValue: 'chrome', description: 'Browser to use for tests')
        activeChoiceParam('TEST_FOLDERS') {
        description('Select one or more test folders to run')
        choiceType('CHECKBOX')   // or MULTI_SELECT
        groovyScript {
            script("""
                def baseDir = new File("${WORKSPACE}/TestSuite")
                if (baseDir.exists()) {
                    return baseDir.list().findAll { new File(baseDir, it).isDirectory() }
                } else {
                    return ['No folders found']
                }
            """)
            fallbackScript("return ['Error detecting folders']")
        }
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
                    def folders = params.TEST_FOLDERS.split(',')
                    for (folder in folders) {
                        echo "▶ Running tests in TestSuite/${folder}"
                        bat "python -m robot --variable BROWSER:${params.BROWSER} --variable HEADLESS:${headlessValue} --outputdir results/${folder.replaceAll('/', '_')} TestSuite/${folder}"
                    }
                }
            }
        }

        stage('Publish Results') {
            steps {
                script {
                    // Merge all outputs into one consolidated report
                    bat "rebot --merge --output results/output.xml --report results/report.html --log results/log.html results/*/output.xml"
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
