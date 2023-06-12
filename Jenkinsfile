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
            emailext body: """
                        <p>EXECUTED: Job <b>\'${env.JOB_NAME}:${env.BUILD_NUMBER}\'</b></p>
                        <p>Status: <b>${status}</b> (currently: ${currentBuild.currentResult}, previously: ${previousBuild.result})</p>
                        <p>View console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME}:${env.BUILD_NUMBER}</a>"</p>""",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                    subject: 'Test',
                    to: 'mabdelgowad144@gmail.com'
        }
    }
}
