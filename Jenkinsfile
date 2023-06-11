pipeline{
    agent any
    stages{
        stage("build image"){
            steps{
                script{
                        docker.build('my-build-image').inside("--volume=/var/run/docker.sock:/var/run/docker.sock") {
                         
                         sh 'docker build -t mahmoudabdelgowad/internimage:1.0 .'
                        }

                    }
                }
            }
        }
}
