# CI/CD with Jenkins (Docker-Based)

This repository demonstrates how to apply CI/CD using Jenkins.  
In this setup, we use a container/Docker-based approach for Jenkins CI/CD and application deployment.

---

## 1. Prerequisites

### Jenkins

For Jenkins, I use a modified `jenkins/jenkins:2.561` image by installing Docker, since I need to build Docker images from my application.

```dockerfile
FROM jenkins/jenkins:2.561

USER root

RUN apt-get update && apt-get install -y docker.io

USER jenkins

```
### Jenkins Agent

For Jenkins AGent, I use a modified `jenkins/agent:alpine-jdk25` because I need maven to build my application.

```dockerfile
FROM jenkins/agent:alpine-jdk25  

USER root

# Install only what we need
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

# Set Maven config path explicitly (avoids surprises)
ENV MAVEN_CONFIG=/home/jenkins/.m2

# Optional: speed up Maven logs
ENV MAVEN_OPTS="-Dmaven.repo.local=/home/jenkins/.m2/repository"

# Quick sanity check (optional but useful)
RUN java -version && docker --version

```

### Socat
To make jenkins communiate with host docker, I also add socat, for this demo, I use alpine/socat:1.8.0.3.

```command
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins -v /var/run/docker.sock:/var/run/docker.sock alpine/socat:1.8.0.3  tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
docker inspect <container_id> | grep IPAddress
```



