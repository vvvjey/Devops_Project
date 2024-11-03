pipeline {
    agent any 

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'sha', url: 'https://github.com/vvvjey/Devops_Project.git'
                echo 'Test GitLab Successfully'
            }
        }

        stage('Clone Repository') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                withDockerRegistry(credentialsId: 'docker', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t napeno/production'
                    sh 'docker push napeno/production'
                }
            }
        }
    }
}
