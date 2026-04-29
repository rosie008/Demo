pipeline {
    agent {
         docker {
                image 'riyadis008/experiment-stuff:jenkins-agent-25-mvn'
                args '-v maven-cache:/home/jenkins/.m2'
            }
      }
    stages {
        stage('Debug Before Build') {
            steps {
                sh '''
                echo "HOME=$HOME"

                echo "=== .m2 directory ==="
                ls -lah $HOME/.m2 || echo "No .m2 yet"

                echo "=== cache size ==="
                du -sh $HOME/.m2 || true
                '''
            }
        }
        stage('Build') {
            steps {
                echo "Building Application.."
                sh '''
                mvn -T 1C clean package -DskipTests
                '''
            }
        }
        stage('Debug After Build') {
            steps {
                sh '''
                echo "=== AFTER BUILD ==="
                du -sh $HOME/.m2 || true

                echo "=== sample repo contents ==="
                ls -lah $HOME/.m2/repository | head -20 || true
                '''
            }
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