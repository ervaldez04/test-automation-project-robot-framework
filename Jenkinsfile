pipeline {
    agent any

    triggers {
        genericTrigger(
            genericVariables: [
                [key: 'action', value: '$.action'],
                [key: 'merged', value: '$.pull_request.merged'],
                [key: 'branch', value: '$.pull_request.base.ref']
            ],
            causeString: 'Triggered by GitHub Pull Request merge',
            token: 'my-secret-token',
            printContributedVariables: true,
            printPostContent: true,
            regexpFilterText: '$action $merged $branch',
            regexpFilterExpression: 'closed true main'
        )
    }
    stages {
        stage('Debug Webhook') {
            steps {
                echo "Action: ${env.action}"
                echo "Merged: ${env.merged}"
                echo "Branch: ${env.branch}"
            }
        }
    }
}
