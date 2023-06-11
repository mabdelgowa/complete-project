pipeline{
    agent any
    stages{
        stage("build image"){
            steps{
                script{
                    echo "building the image of application"
                        sh 'sudo docker build -t mahmoudabdelgowad/internimage:1.0 .'

                    }
                }
            }
        }
}
