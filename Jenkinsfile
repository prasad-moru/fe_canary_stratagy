pipeline {
    agent any 

    environment {
        GCP_PROJECT_ID = 'eternal-arcana-222507'
        IMAGE_NAME = 'react-app'
        GCR_REGISTRY = 'gcr.io'
        GCR_CREDENTIALS_ID = 'gcr-service-account'
        GIT_CREDENTIALS_ID = 'git-credentials-id'
        KUBERNETES_NAMESPACE = 'react-app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Image Tag') {
            steps {
                script {
                    def buildNum = env.BUILD_NUMBER.toInteger()
                    def formattedBuildNum = String.format("%03d", buildNum)
                    env.IMAGE_TAG = formattedBuildNum
                    echo "Set IMAGE_TAG to ${env.IMAGE_TAG}"
                }
            }
        }

        stage('Build React (Optional)') {
            steps {
                sh """
                  npm install
                  npm run build
                """
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "Building Docker image with tag: ${env.IMAGE_TAG}"
                    sh """
                      docker build -t ${GCR_REGISTRY}/${GCP_PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Docker Login & Push to GCR') {
            steps {
                withCredentials([file(credentialsId: "${GCR_CREDENTIALS_ID}", variable: 'GCR_KEY')]) {
                    sh """
                        echo "Logging in to GCR..."
                        cat \$GCR_KEY | docker login -u _json_key --password-stdin https://${GCR_REGISTRY}
                        
                        echo "Pushing image to GCR..."
                        docker push ${GCR_REGISTRY}/${GCP_PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Update Helm Values') {
            steps {
                script {
                    sh '''
                        if ! command -v yq &> /dev/null
                        then
                            echo "yq not found, installing..."
                            wget https://github.com/mikefarah/yq/releases/download/v4.30.6/yq_linux_amd64 -O /usr/local/bin/yq
                            chmod +x /usr/local/bin/yq
                        else
                            echo "yq is already installed."
                        fi
                    '''

                    // Update the image tag in values.yaml
                    sh """
                        yq eval '.image.tag = "${env.IMAGE_TAG}"' -i helm/react-app/values.yaml
                    """

                    // Display the updated values.yaml for verification
                    sh "cat helm/react-app/values.yaml"

                    // Commit and push the changes back to the repository
                    withCredentials([usernamePassword(credentialsId: "${GIT_CREDENTIALS_ID}", usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD')]) {
                        sh """
                            git config user.email "jenkins@yourdomain.com"
                            git config user.name "Jenkins CI"
                            
                            git add helm/react-app/values.yaml
                            git commit -m "Update image tag to ${env.IMAGE_TAG}"
                            
                            # Extract Git URL and inject credentials
                            GIT_URL=$(git config --get remote.origin.url)
                            GIT_URL_WITH_CREDS=${GIT_URL/https:\/\//https://${GIT_USER}:${GIT_PASSWORD}@/}
                            
                            git push ${GIT_URL_WITH_CREDS} HEAD:${env.BRANCH_NAME}
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-id', variable: 'KUBECONFIG')]) {
                    sh """
                        echo "Deploying to Kubernetes..."

                        # Deploy stable release
                        helm upgrade --install react-app-stable helm/react-app \\
                            --namespace ${env.KUBERNETES_NAMESPACE} \\
                            --create-namespace \\
                            --set release=stable

                        # Deploy canary release
                        helm upgrade --install react-app-canary helm/react-app \\
                            --namespace ${env.KUBERNETES_NAMESPACE} \\
                            --set release=canary \\
                            --set image.tag=${env.IMAGE_TAG}
                    """
                }
            }
        }

        stage('Clean Up') {
            steps {
                sh """
                  docker rmi ${GCR_REGISTRY}/${GCP_PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG} || true
                """
            }
        }
    }

    post {
        always {
            // Clean up any dangling Docker resources
            sh 'docker system prune -f || true'
        }
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
