pipeline {
    agent any 

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'sha', url: 'https://github.com/vvvjey/Devops_Project.git'
                echo 'Test GitLab Successfully'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_TOKEN')]) {
                        sh '''
                            /opt/sonar-scanner/bin/sonar-scanner \
                            -Dsonar.projectKey=Devops_Project \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://137.184.144.191:9000 \
                            -Dsonar.login=${SONAR_TOKEN}
                        '''
                    }
                }
            }
        }

        stage('Snyk: Check Node.js Dependencies') {
            steps {
                dir('my-app') {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                            sh '''
                                snyk auth ${SNYK_TOKEN}
                                snyk test --file=package.json
                            '''
                        }
                    }
                }
            }
        }

        stage('Snyk: Fix Node.js Vulnerabilities') {
            steps {
                dir('my-app') {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                            sh '''
                                snyk auth ${SNYK_TOKEN}
                                snyk wizard --file=package.json
                                npm install
                            '''
                        }
                    }
                }
            }
        }

        stage('Snyk: Check Docker Compose Security') {
            steps {
                dir('production') {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                            sh '''
                                snyk auth ${SNYK_TOKEN}
                                snyk iac test docker-compose.yaml
                            '''
                        }
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') {
                        sh '''
                            docker build -t napeno/production:latest -f Dockerfile .
                            docker push napeno/production
                        '''
                    }
                }
            }
        }

        stage('Snyk: Check Dockerfile Security') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                        sh '''
                            snyk auth ${SNYK_TOKEN}
                            snyk container test napeno/production:latest --file=Dockerfile
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            mail bcc: '', body: 'Pipeline completed successfully!', cc: '21522029@gm.uit.edu.vn', from: '', replyTo: '', subject: 'Pipeline Success', to: '21522029@gm.uit.edu.vn'
        }
        failure {
            mail bcc: '', body: 'Pipeline failed. Please check the logs.', cc: '21522029@gm.uit.edu.vn', from: '', replyTo: '', subject: 'Pipeline Failure', to: '21522029@gm.uit.edu.vn'
        }
        always {
            echo 'Pipeline finished!'
        }
    }
}
