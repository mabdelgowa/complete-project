pipeline{
        environment {
        registry = "region_code.ocir.io/namespace/acmewebsite"
        registryCredential = 'ocir'
        dockerImage = ''
    }
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
