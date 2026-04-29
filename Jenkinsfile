pipeline {
    agent {
         docker {
                image 'riyadis008/experiment-stuff:jenkins-agent-25-mvn'
                args '-v maven-cache:/home/jenkins/.m2'
            }
      }
    stages {
        stage('Build') {
            steps {
                echo "Building Application.."
                sh '''
                mvn -T 1C clean package -DskipTests
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
    }
}