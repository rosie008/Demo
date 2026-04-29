pipeline {
    agent {
        node {
            label 'docker-agent-java'
            }
      }
    stages {
        stage('Debug Before Build') {
        steps {
            sh '''
            echo "HOME=$HOME"
            ls -lah $HOME/.m2 || echo "No .m2 yet"
            '''
            }
        }
        stage('Build') {
            steps {
                echo "Building Application.."
                sh '''
                chmod +x mvnw
                ./mvnw -T 1C clean package -DskipTests
                '''
            }
        }

        stage('Debug After Build') {
            steps {
                sh '''
                ls -lah $HOME/.m2/repository | head -20
                du -sh $HOME/.m2 || true
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