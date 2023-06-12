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
 pst {
        failure {
              mail( to: 'mabdelgowad144@gmail.com',
                 
                subject: "FAILED: Build ${env.JOB_NAME}", 
                body: "Build failed ${env.JOB_NAME} build no: ${env.BUILD_NUMBER}.\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        )
        }
    }
}
