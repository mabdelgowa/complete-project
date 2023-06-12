pipeline{
        environment {
        registry = "docker.io/namespace/acmewebsite"
        registryCredential = 'docker-hub'
        dockerImage = ''
    }
    agent any
    stages{
        stage("build image"){
            steps{
                script{
                    echo "building the image of application"
                    sh 'docker build -t mahmoudabdelgowad/my-images:3.0 .'
                    docker.withRegistry( 'https://docker.io', registryCredential ) {
                    sh 'docker push mahmoudabdelgowad/my-images:3.0 '
                    }

                    }
                }
            }
        }
    post {
        always {
            emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
        }
    }
}
