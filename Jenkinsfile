pipeline {
    agent any

    triggers {
        GenericTrigger(
            genericVariables: [
                [key: 'action', value: '$.action'],
                [key: 'merged', value: '$.pull_request.merged'],
                [key: 'targetBranch', value: '$.pull_request.base.ref'],
                [key: 'sourceBranch', value: '$.pull_request.head.ref']
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
                echo "=== Webhook Debug Info ==="
                echo "Action: ${env.action}"
                echo "Merged: ${env.merged}"
                echo "Target Branch: ${env.targetBranch}"
                echo "Source Branch: ${env.sourceBranch}"
                echo "=========================="
            }
        }
    }
}
