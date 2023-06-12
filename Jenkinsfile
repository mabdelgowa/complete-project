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
                        
                         dockerImage = docker.build(registry + ":${1.0}")
                        

                    }
                }
            }
        }
}
