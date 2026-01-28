pipeline {
    agent any

    environment {
        IMAGE_NAME = "java-hello"
        CONTAINER_NAME = "java-hello-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out source code"
                checkout scm
            }
        }

        stage('Build Java Code') {
            steps {
                echo "Compiling Java program"
                sh '''
                    javac HelloWorld.java
                '''
            }
        }

        stage('Test') {
            steps {
                echo "Running basic test"
                sh '''
                    java HelloWorld | grep "Hello from Java"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image"
                sh '''
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying Docker container"
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run --name $CONTAINER_NAME -d $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build, Test & Deploy Successful"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
