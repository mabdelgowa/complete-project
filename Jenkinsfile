pipeline{
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
