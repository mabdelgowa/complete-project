pipeline{
  environment {
    registry = "docker.io/namespace/acmewebsite"
    registryCredential = 'docker-hub'
    dockerImage = ''
    AWS_ACCESS_KEY_ID = credentials('jenkins_access_key_id')
    AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
    TF_VAR_env_prefix = 'test'
    KUBECONFIG = credentials('kubeconfig') 
  }
  agent any
      parameters {
        choice(
            name: 'Deployment',
            choices: ['kubernetes', 'EC2', 'None'],
            description: 'Select the deployment environment'
        )
      }
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
    stage('provision server'){
        when {
                expression { params.Deployment == 'EC2' }
            }
       steps{
            script{
                dir('terraform'){
                    sh "terraform init"
                    sh "terraform apply --auto-approve"
                }
            }
       }
    }
    stage('deploy'){
      when {
                expression { params.Deployment == 'kubernetes' }
            }
      steps{
        script{
          sh 'kubectl apply -f  /var/lib/jenkins/workspace/intern/auto_scaling_and_secrets/app.yaml'
        }
      }
    }
  }
  post {
    failure {
      mail( to: 'mabdelgowad144@gmail.com',

              subject: "FAILED: Build ${env.JOB_NAME}",
              body: "Build failed ${env.JOB_NAME} build no: ${env.BUILD_NUMBER}.\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
      )
    }
  }
}
