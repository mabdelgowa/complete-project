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
        script {
            // see https://stackoverflow.com/a/59739297/42610 for details
            if (currentBuild.currentResult == 'ABORTED') {
                return
            }

            def previousBuild = currentBuild.previousBuild
            while(previousBuild != null && previousBuild.result == 'ABORTED') {
                echo "Skipping over an aborted build ${previousBuild.fullDisplayName}"
                previousBuild = previousBuild.previousBuild;
            }
            def isFailure = currentBuild.currentResult == 'FAILURE'
            def wasFailure = previousBuild.result == 'FAILURE'
            echo "Is: ${currentBuild.currentResult} (${isFailure})"
            echo "Was: ${previousBuild.result} (${wasFailure})"

            def status = null
            if (isFailure && !wasFailure) {
                status = 'New failure'
            } else if (isFailure) {
                status = 'Still failure'
            } else if (wasFailure) {
                status = 'Failure fixed'
            }

            if (status != null) {
                emailext(
                    to: 'mabdelgowad144l@gmail.com',
                    subject: "${status}: Job \'${env.JOB_NAME}:${env.BUILD_NUMBER}\'",
                    body: """
                        <p>EXECUTED: Job <b>\'${env.JOB_NAME}:${env.BUILD_NUMBER}\'</b></p>
                        <p>Status: <b>${status}</b> (currently: ${currentBuild.currentResult}, previously: ${previousBuild.result})</p>
                        <p>View console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME}:${env.BUILD_NUMBER}</a>"</p>"""
                )
            }
        }
    }
}
}
