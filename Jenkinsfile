pipeline {
    agent {
        node {
            label 'docker-agent-java'
            }
      }
    stages {
        stage('Build') {
            steps {
                echo "Building Application.."
                sh '''
                chmod +x mvnw
                ./mvnw clean package -DskipTests
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                echo "doing test stuff..""
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deliver....'
                sh '''
                echo "doing deploy stuff.."
                '''
            }
        }
    }
}