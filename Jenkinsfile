pipeline {
    agent any

    parameters {
        choice(
            choices: ['maven', 'gradle'],
            description: 'Choose the build tool',
            name: 'BUILD_TOOL'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'This stage reads the repository'
                git 'https://github.com/HorutskaL/Builders.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    def buildTool = params.BUILD_TOOL
                    def buildCommand

                    if (buildTool == 'maven') {
                        buildCommand = 'mvn clean install'
                    } else if (buildTool == 'gradle') {
                        buildCommand = 'gradle clean build'
                    } else {
                        error "Invalid build tool: ${buildTool}"
                    }
                    bat buildCommand
                }
            }
            post {
                success {
                    // Automatically apply first promotion (QA) on successful build
                    script {
                        if (isManualPromotionRequired()) {
                            input message: 'Please approve the deployment to QA.', submitter: 'user', parameters: [booleanParam(defaultValue: false, description: 'Approve Deployment?', name: 'APPROVE_QA')]
                        }
                    }
                }
                unstable {
                    // Require manual input to proceed with the second promotion (Prod)
                    script {
                        if (isManualPromotionRequired()) {
                            input message: 'Please approve the deployment to Prod.', submitter: 'user', parameters: [booleanParam(defaultValue: false, description: 'Approve Deployment?', name: 'APPROVE_PROD')]
                        }
                    }
                }
            }
        }
    }
}

def isManualPromotionRequired() {
    return currentBuild.result != 'SUCCESS'
}
