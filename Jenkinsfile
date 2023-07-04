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
        sh "docker stop docker-fastapi-test_container || true" 
        sh "docker rm docker-fastapi-test_container || true" 
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
        
        stage('Install Docker On Server') { 
             steps { 
               ansiblePlaybook(inventory: 'inventory.yml', playbook: 'deploy.yml') 
        } 
    } 
  
       stage('Pull Image') { 
            steps { 
        sshagent(credentials: ['my-ssh-key']) { 
            sh 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@44.211.146.68 sudo docker pull kausthubhbhosekar/docker-fastapi-test:latest' 

            } 
          }  
        } 

        stage('Run App') {
            steps {
        sshagent(credentials: ['my-ssh-key']) {
            sh 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@44.211.146.68 sudo docker run -d --name docker-fastapi-test_container kausthubhbhosekar/docker-fastapi-test:latest'

           }
        }
      }   

  }
} 
