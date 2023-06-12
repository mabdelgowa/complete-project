pipeline{
    agent any
    stages{
        stage("build image"){
            steps{
                script{
                    echo "building the image of application"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER' )]){
                    sh 'docker build -t mahmoudabdelgowad/my-images:3.0 .'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push mahmoudabdelgowad/my-images:3.0'
                    }

                    }
                }
            }
        }
}
