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


        // stage('Snyk: Check Dockerfile Security') {
        //     steps {
        //         catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
        //             withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
        //                 script {
        //                     // Define the paths to Dockerfiles
        //                     def dockerfilePaths = [
        //                         './my-app/Dockerfile',
        //                         './Backend/Dockerfile',
        //                         './Sql/Dockerfile'
        //                     ]

        //                     // Loop through each Dockerfile and run Snyk test
        //                     for (dockerfile in dockerfilePaths) {
        //                         echo "Checking security for Dockerfile at: ${dockerfile}"
        //                         sh """
        //                             snyk auth ${SNYK_TOKEN}
        //                             snyk container test --file=${dockerfile} .
        //                         """
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // }

        stage('Fetch Latest Docker Hub Tags') {
            steps {
                script {
                    // Define images to fetch tags
                    def images = [
                        'napeno/frontend',
                        'napeno/backend',
                        'napeno/sql'
                    ]

                    // Function to fetch latest tag
                    def getLatestTag = { image ->
                        def apiUrl = "https://registry.hub.docker.com/v2/repositories/${image}/tags/?page_size=1"
                        def response = sh(script: "curl -s ${apiUrl} | jq -r '.results[0].name'", returnStdout: true).trim()
                        return response ?: "latest" // Default to 'latest' if no tag found
                    }

                    // Fetch latest tags and store them
                    def latestTags = [:]
                    for (image in images) {
                        echo "Fetching latest tag for: ${image}"
                        def tag = getLatestTag(image)
                        echo "Latest tag for ${image}: ${tag}"
                        latestTags[image] = tag
                    }

                    // Set environment variables for later stages
                    env.LATEST_MY_APP_TAG = latestTags['napeno/my-app']
                    env.LATEST_BACKEND_TAG = latestTags['napeno/backend']
                    env.LATEST_SQL_TAG = latestTags['napeno/sql']
                }
            }
        }

        stage('Snyk: Check Dockerfile Security') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                        script {
                            // Define Dockerfiles and their corresponding images using fetched tags
                            def dockerConfigs = [
                                [path: './my-app', tag: "napeno/my-app:${env.LATEST_MY_APP_TAG}"],
                                [path: './Backend', tag: "napeno/backend:${env.LATEST_BACKEND_TAG}"],
                                [path: './Sql', tag: "napeno/sql:${env.LATEST_SQL_TAG}"]
                            ]

                            // Loop through each Dockerfile and scan with Snyk
                            for (config in dockerConfigs) {
                                echo "Scanning Dockerfile at: ${config.path}/Dockerfile with image: ${config.tag}"
                                try {
                                    sh """
                                        snyk auth ${SNYK_TOKEN}
                                        snyk container test ${config.tag} --file=${config.path}/Dockerfile
                                    """
                                    echo "Security scan passed for ${config.path}/Dockerfile"
                                } catch (Exception e) {
                                    echo "Security vulnerabilities found in ${config.path}/Dockerfile. Continuing process."
                                }
                            }
                        }
                    }
                }
            }
        }


        stage('Build and Push Docker Images') {
            steps {
                withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') {
                    script {
                        def gitCommit = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                        def timestamp = sh(returnStdout: true, script: 'date +"%Y%m%d%H%M%S"').trim()

                        // Define services and corresponding Docker images
                        def images = [
                            [path: './Backend', image: "napeno/backend:${gitCommit}-${timestamp}"],
                            [path: './Sql', image: "napeno/sql:${gitCommit}-${timestamp}"],
                            [path: './my-app', image: "napeno/frontend:${gitCommit}-${timestamp}"]
                        ]

                        // Build and push Docker images
                        for (img in images) {
                            echo "Building image: ${img.image} from path: ${img.path}"
                            retry(3) {
                                sh """
                                    docker build --build-arg GIT_COMMIT=${gitCommit} --no-cache --network=host -t ${img.image} ${img.path}
                                """
                            }
                            echo "Successfully built: ${img.image}"

                            echo "Pushing image: ${img.image}"
                            retry(3) {
                                sh """
                                    docker push ${img.image}
                                """
                            }
                            echo "Successfully pushed: ${img.image}"
                        }

                        // Set environment variables for next stage
                        env.FRONTEND_IMAGE_TAG = images.find { it.path == './my-app' }.image.split(':')[1]
                        env.BACKEND_IMAGE_TAG = images.find { it.path == './Backend' }.image.split(':')[1]
                        env.SQL_IMAGE_TAG = images.find { it.path == './Sql' }.image.split(':')[1]
                    }
                }
            }
        }



        // stage('Build and Test Docker Images') {
        //     steps {
        //         withDockerRegistry(credentialsId: 'docker_jenkins', url: 'https://index.docker.io/v1/') { 
        //             script {
        //                 def gitCommit = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
        //                 def timestamp = sh(returnStdout: true, script: 'date +"%Y%m%d%H%M%S"').trim()

        //                 // Generate dynamic tags for each service
        //                 def frontendTag = "frontend:${gitCommit}-${timestamp}"
        //                 def backendTag = "backend:${gitCommit}-${timestamp}"
        //                 def sqlTag = "sql:${gitCommit}-${timestamp}"

        //                 // List of services to build
        //                 def images = [
        //                     [path: './Backend', image: "napeno/${backendTag}"],
        //                     [path: './Sql', image: "napeno/${sqlTag}"],
        //                     [path: './my-app', image: "napeno/${frontendTag}"]
        //                 ]

        //                 for (img in images) {
        //                     echo "Building image: ${img.image} from path: ${img.path}"
        //                     retry(3) {
        //                         sh """
        //                             docker build --build-arg GIT_COMMIT=${gitCommit} --no-cache --network=host -t ${img.image} ${img.path}
        //                         """
        //                     }
        //                     echo "Successfully built: ${img.image}"

        //                     // Test API if the service is backend
        //                     if (img.image.contains("backend")) {
        //                         echo "Testing the backend API..."
        //                        try {
        //                             sh """
        //                                 docker run -d --name test-container \
        //                                 -p 5000:5000 \
        //                                 -e DB_HOSTNAME='146.190.184.196' \
        //                                 -e DB_PORT='3306' \
        //                                 -e DB_DIALECT='mysql' \
        //                                 -e DB_DATABASE='web_cv' \
        //                                 -e DB_USERNAME='root' \
        //                                 -e DB_PASSWORD='123' \
        //                                 ${img.image}
        //                                 sleep 20
        //                                 echo "Container logs:"
        //                                 docker logs test-container
        //                             """
        //                             def apiResponse = sh(returnStdout: true, script: """
        //                                 curl -s -w "\\nHTTP Status: %{http_code}" http://localhost:5000/api/get-five-newest-products
        //                             """).trim()
        //                             echo "API Response: ${apiResponse}"

        //                             // // Optional: Run Postman tests if needed
        //                             // sh """
        //                             //     docker run --rm \
        //                             //     -v \$(pwd):/etc/newman \
        //                             //     postman/newman:latest \
        //                             //     run postman_collection.json \
        //                             //     --env-var baseUrl=http://localhost:5000 \
        //                             //     --env-var apiEndpoint=/api/get-five-newest-products
        //                             // """


        //                             echo "Backend API test passed successfully"
        //                         } finally {
        //                             // Clean up the container
        //                             sh "docker rm -f test-container"
        //                         }

        //                     }
        //                 }

        //                 // Push the images to Docker Hub
        //                 for (img in images) {
        //                     echo "Pushing image: ${img.image}"
        //                     retry(3) {
        //                         sh """
        //                             docker push ${img.image}
        //                         """
        //                     }
        //                     echo "Successfully pushed: ${img.image}"
        //                 }

        //                 // Set environment variables for the next stage
        //                 env.FRONTEND_IMAGE_TAG = frontendTag
        //                 env.BACKEND_IMAGE_TAG = backendTag
        //                 env.SQL_IMAGE_TAG = sqlTag
        //             }
        //         }
        //     }
        // }


        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo 'Deploying application to Kubernetes'
                    sh """
                        export KUBECONFIG=/var/lib/jenkins/.kube/config

                        helm upgrade --install backend-app ./helm/backend \
                        --set image.repository=napeno/backend \
                        --set image.tag=${BACKEND_IMAGE_TAG} \
                        --set image.pullPolicy=Always \
                        --set service.type=LoadBalancer \
                        --force

                        helm upgrade --install frontend-app ./helm/frontend \
                        --set image.repository=napeno/frontend \
                        --set image.tag=${FRONTEND_IMAGE_TAG} \
                        --set image.pullPolicy=Always \
                        --set service.type=LoadBalancer \
                        --force

                        helm upgrade --install sql-app ./helm/sql \
                        --set image.repository=napeno/sql \
                        --set image.tag=${SQL_IMAGE_TAG} \
                        --set image.pullPolicy=Always \
                        --set service.type=LoadBalancer \
                        --force
                    """
                    echo 'Deployment completed successfully'
                }
            }
        }

        stage('Canary Rollout') {
            steps {
                script {
                    echo 'Initiating Canary Deployment'
                    sh """
                        kubectl argo rollouts set image frontend-rollout frontend=napeno/${FRONTEND_IMAGE_TAG}
                        kubectl argo rollouts promote frontend-rollout
                    """
                }
            }
        }
        
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
