pipeline {
    agent any
    
    parameters {
        choice(
            choices: ['maven', 'gradle'],
            description: 'Choose the build tool',
            name: 'BUILD_TOOL'
        )
        text (defaultValue: 'This is the change log', 
              description: 'Enter the change log.', 
              name: 'CHANGELOG')
    }
   
    stages {
        stage('Checkout') {
            steps {
                echo 'This stage reads repository'
                git 'https://github.com/HorutskaL/Builders.git'
            }
        }
        

        stage('Build') {
            
            steps {
                script {
                    def buildTool = params.BUILD_TOOL
                    def buildCommand
                    
                    if (buildTool == 'maven') {
                        buildCommand= 'mvn clean install'
                    } else if (buildTool == 'gradle') {
                        buildCommand= 'gradle clean build'
                    } else {
                        error "Invalid build tool: ${buildTool}"
                    }
                    bat buildCommand
                }
            }
        }
    }
    
    }
