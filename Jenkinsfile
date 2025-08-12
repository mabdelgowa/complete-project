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
         withKubeConfig([credentialsId: 'kubeconfig']){
	     sh 'kubectl apply -f  /var/lib/jenkins/workspace/intern/auto_scaling_and_secrets/mysql-secret.yaml'
	     sh 'if ! kubectl get cm my-configmap >/dev/null 2>&1; then kubectl create cm sqlhost --from-literal MYSQL_HOST=$(kubectl get svc mysql-service | awk 'NR==2 {print $3}'); fi'
          sh '''
             kubectl apply -f  /var/lib/jenkins/workspace/intern/auto_scaling_and_secrets/mysql-config.yaml
             kubectl apply -f  /var/lib/jenkins/workspace/intern/auto_scaling_and_secrets/mysql.yaml
	     kubectl apply -f  /var/lib/jenkins/workspace/intern/auto_scaling_and_secrets/app.yaml
	     if kubectl get svc my-service >/dev/null 2>&1; then echo "Exists"; else  kubectl expose deployment app-deployment   --target-port=9090 --type=ClusterIP --name=my-service; fi
             kubectl apply -f  /var/lib/jenkins/workspace/intern/auto_scaling_and_secrets/ingress.yaml
	    '''
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
