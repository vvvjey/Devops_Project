pipeline {
    agent any 

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'sha', url: 'https://github.com/vvvjey/Devops_Project.git'
                echo 'Test GitLab Successfully'
            }
        }

        stage('SonarQube Analysis') { //test
            steps {
                withSonarQubeEnv('SonarQube') {
                    withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_TOKEN')]) {
                        sh '''
                            sonar-scanner \
                            -Dsonar.projectKey=Devops_Project \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://137.184.144.191:9000 \
                            -Dsonar.login=${SONAR_TOKEN}
                        '''
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t napeno/production:latest -f Dockerfile .'
                    sh 'docker push napeno/production'
                }
            }
        }
    }
    post {
        always {
            mail bcc: '', body: 'Mail from Jenkins successfully', cc: '21522029@gm.uit.edu.vn', from: '', replyTo: '', subject: 'Mail from Jenkins successfully', to: '21522029@gm.uit.edu.vn'
        }
    }
}
