pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ervaldez04/test-automation-project-robot-framework.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m pip install --upgrade pip
                    python --version
                    pip install -r requirements.txtt 
                '''
            }
        }
    }
}
