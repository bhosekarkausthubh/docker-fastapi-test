pipeline { 
    agent any 

    environment { 
        DOCKERHUB_USERNAME = credentials('DOCKERHUB_USERNAME') 
        DOCKERHUB_PASSWORD = credentials('DOCKERHUB_PASSWORD') 
       ANSIBLE_HOST_KEY_CHECKING = 'False' 
    } 
 
    stages { 
        stage('Build image') { 
            steps { 
                script { 
                    docker.build("kausthubhbhosekar/docker-fastapi-test:latest") 
                } 
            } 
        } 
        stage('Push image') { 
            steps { 
                sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD" 
                script { 
                    def imageName = "kausthubhbhosekar/docker-fastapi-test:latest" 
                    def dockerImage = docker.image(imageName) 
                    dockerImage.push() 
                } 
            } 
        } 
        stage('Delete Docker container') { 
             steps { 
        sh "docker stop dockerjenkins_container || true" 
        sh "docker rm dockerjenkins_container || true" 
    } 
} 
        stage('Deploy image') { 
            steps { 
                sh "docker run -d --name docker-fastapi-test_container kausthubhbhosekar/docker-fastapi-test:latest" 
            } 
        } 
        stage('Check Docker logs') { 
            steps { 
                sh "docker logs docker-fastapi-test_container" 
            } 
        } 
        stage('Deploy Docker container') { 
             steps { 
               ansiblePlaybook(inventory: 'inventory.yml', playbook: 'deploy.yml') 
        } 
} 
    } 
} 

 

 
