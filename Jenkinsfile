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
        stage('Deploy') {
            steps {
                echo "Deploying Docker Image with Environment Variables..."
                sh '''
                docker run -d \
                  --name java-jenkins-demo \
                  --network test-network \
                  -p 8081:8181 \
                  -e db.name="${DB_NAME}" \
                  -e db.host="${DB_HOST}" \
                  -e db.port="${DB_PORT}" \
                  -e db.username="${DB_USERNAME}" \
                  -e db.password="${DB_PASSWORD}" \
                  -e redis.host="${REDIS_HOST}" \
                  -e redis.port="${REDIS_PORT}" \
                  -e redis.password="${REDIS_PASSWORD}" \
                  riyadis008/experiment-stuff:java-demo-1
                '''
            }
        }
    }
}