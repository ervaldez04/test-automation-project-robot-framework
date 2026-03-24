pipeline {
    agent {
        // Use a Python-ready agent or Docker image
        docker {
            image 'python:3.11'
            args '-u root'  // run as root if you need system installs
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
                sh '''
                    python --version
                    python -m pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
    }
}
