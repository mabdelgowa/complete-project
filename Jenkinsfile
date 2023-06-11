pipeline{
    agent any
    stages{
        stage("build image"){
            steps{
                script{
                        
                         
                         sh 'podman build -t mahmoudabdelgowad/internimage:1.0 .'
                        

                    }
                }
            }
        }
}
