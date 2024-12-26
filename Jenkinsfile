pipeline {
    agent any 

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'sha', url: 'https://github.com/vvvjey/Devops_Project.git'
                echo 'Repository cloned successfully'
            }
        }

        stage('Lint YAML and Helm Charts') {
            steps {
                script {
                    echo 'Linting Kubernetes YAML files and Helm charts'
                    sh '''
                        yamllint deployment.yaml
                        helm lint ./helm
                    '''
                }
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

        // stage('Build Docker Image') {
        //     steps {
        //         catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
        //             withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') {
        //                 sh '''
        //                     docker build -t napeno/production:latest -f Dockerfile .
        //                     docker push napeno/production
        //                 '''
        //             }
        //         }
        //     }
        // }

        stage('Build and Push Docker Images') {
            steps {
                withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') { 
                    script {
                        def branch = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                        def tag = branch == 'main' ? 'latest' : branch

                        def images = [
                            [path: './Backend', image: "napeno/backend:${tag}"],
                            [path: './Sql', image: "napeno/sql:${tag}"],
                            [path: './my-app', image: "napeno/frontend:${tag}"]
                        ]

                        for (img in images) {
                            echo "Building and pushing image: ${img.image} from path: ${img.path}"
                            retry(3) {
                                sh """
                                    docker build --build-arg GIT_COMMIT=$(git rev-parse HEAD) --no-cache --network=host -t ${img.image} ${img.path}
                                    docker push ${img.image}
                                """
                            }
                            echo "Successfully built and pushed: ${img.image}"
                        }
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

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         script {
        //             echo 'Deploying application to Kubernetes'
        //             sh '''
        //                 helm upgrade --install backend-app ./helm/backend \
        //                 --set image.repository=napeno/backend \
        //                 --set image.tag=latest \
        //                 --set image.pullPolicy=Always \
        //                 --set service.type=LoadBalancer \
        //                 --force

        //                helm upgrade --install frontend-app ./helm/frontend \
        //                 --set image.repository=napeno/frontend \
        //                 --set image.tag=latest \
        //                 --set image.pullPolicy=Always \
        //                 --set service.type=LoadBalancer \
        //                 --force

        //                 helm upgrade --install sql-app ./helm/sql \
        //                 --set image.repository=napeno/sql \
        //                 --set image.tag=latest \
        //                 --set image.pullPolicy=Always \
        //                 --set service.type=LoadBalancer \
        //                 --force
        //             '''
        //             echo 'Deployment completed successfully'
        //         }
        //     }
        // }

        stage('Validate Deployment') {
            steps {
                script {
                    echo 'Validating Kubernetes deployment'
                    sh '''
                        kubectl get pods -o wide
                        kubectl get svc -o wide
                    '''
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
