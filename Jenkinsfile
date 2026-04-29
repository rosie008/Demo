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
        stage('Push') {
            steps {
                echo "Push Docker Image.."
                sh '''
                docker build -t riyadis008/experiment-stuff:java-demo-1 .
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh '''
                echo "doing deploy stuff.."
                '''
            }
        }
    }
}