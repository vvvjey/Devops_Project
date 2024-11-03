pipeline {
    agent any 

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'sha', url: 'https://github.com/vvvjey/Devops_Project.git'
                echo 'Test GitLab Successfully'
            }
        }

        stage('Build Docker Image') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t napeno/production'
                    sh 'docker push napeno/production'
                }
            }
        }
    }
}
