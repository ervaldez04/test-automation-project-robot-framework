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
                    bat bat 'python -m pip install --upgrade pip'
                    bat 'pip install -r requirements.txt'
                    python --version
            }
        }
    }
}
