# CI/CD with Jenkins (Docker-Based)

This repository demonstrates a Docker-based CI/CD setup using Jenkins for both pipeline execution and application deployment.

---

## 1. Prerequisites

### Jenkins

Jenkins runs from a custom `jenkins/jenkins:2.561` image with Docker installed, so Jenkins can build Docker images for the application.

```dockerfile
FROM jenkins/jenkins:2.561

USER root

RUN apt-get update && apt-get install -y docker.io

USER jenkins
```

Run Jenkins with:

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  riyadis008/experiment-stuff:jenkins-docker
```

### Jenkins Agent

The Jenkins agent uses a customized `jenkins/agent:alpine-jdk25` image with Maven and supporting tools installed for application builds.

```dockerfile
FROM jenkins/agent:alpine-jdk25

USER root

# Install required tools
RUN apk add --no-cache \
    docker-cli \
    git \
    bash \
    curl \
    maven

# Allow jenkins user to access docker group (for docker.sock)
RUN addgroup jenkins docker || true

# Prepare Maven cache directory (important for volume mount)
RUN mkdir -p /home/jenkins/.m2 \
    && chown -R jenkins:jenkins /home/jenkins/.m2

USER jenkins

# Set Maven config path explicitly
ENV MAVEN_CONFIG=/home/jenkins/.m2

# Optional: local Maven repository path
ENV MAVEN_OPTS="-Dmaven.repo.local=/home/jenkins/.m2/repository"

# Optional sanity check
RUN java -version && docker --version
```

### Socat

To allow Jenkins to communicate with the host Docker daemon, this demo uses `alpine/socat:1.8.0.3`.

```bash
docker pull alpine/socat:1.8.0.3
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins -v /var/run/docker.sock:/var/run/docker.sock alpine/socat:1.8.0.3 tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
docker inspect <container_id> | grep IPAddress
```

### PostgreSQL and Redis

To support application connectivity in this demo, use:
- `postgres:17-alpine3.22`
- `redis:7-alpine3.21`

Configuration details are available in `docker-compose.yml` and `.env`.

## 2. Jenkins Plugins

### Docker

Used to enable Jenkins cloud configuration.

### Docker Pipeline

Used to build Docker images from Jenkins pipelines.
