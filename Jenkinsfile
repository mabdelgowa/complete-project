pipeline{
    agent any
    stages{
        stage("build image"){
            steps{
                script{
                    echo "building the image of application"
                    withCredentials([usernamePassword(credentialsID: 'Docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER' )]){
                        sh 'docker build -t mahmoudabdelgowad/internimage:1.0 .'
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh 'docker push mahmoudabdelgowad/internimage:1.0'
                    }
                }
            }
        }
        stage("deploy"){
            steps{
                script{
                echo "deploying the application"
                }
            }
        }
    }
}
