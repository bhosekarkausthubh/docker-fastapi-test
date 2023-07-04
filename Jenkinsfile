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
  
        stage('Deploy Docker container') { 
             steps { 
               ansiblePlaybook(inventory: 'inventory.yml', playbook: 'deploy.yml') 
        } 
    } 
  }  
} 

 

 
