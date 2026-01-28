pipeline {
    agent any

    environment {
        IMAGE_NAME = "sonajerry/java-hello"
        CONTAINER_NAME = "java-hello-container"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Java') {
            steps {
                sh 'javac HelloWorld.java'
            }
        }

        stage('Test') {
            steps {
                sh 'java HelloWorld | grep "Hello from Java"'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $IMAGE_NAME'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run -d --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Docker image built, pushed & deployed successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}
