node {
stage('SCM Checkout')
{
git 'https://github.com/tejasrik/End-to-end-pipeline.git'
}
/*stage("Terraform init/plan/apply"){
	

     withCredentials([string(credentialsId: 'aws-access-id', variable: 'AWS_ACCESS_KEY_ID'),
		      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]){
   
	sh "terraform destroy -auto-approve"
     }
}
}*/

stage("Terraform init/plan/apply"){
	

     withCredentials([string(credentialsId: 'aws-access-id', variable: 'AWS_ACCESS_KEY_ID'),
		      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]){
    dir('./terraform-eks') {
     def tfHome = tool name: 'TF_PATH', type: 'terraform'
     
     sh "${tfHome}/terraform init"
     sh "${tfHome}/terraform plan"
     if (fileExists('$HOME/.kube')) {
					echo '.kube Directory Exists'
				} else {
				sh 'mkdir -p $HOME/.kube'
				}
				sh """
					${tfHome}/terraform apply -auto-approve
					${tfHome}/terraform output kubeconfig > $HOME/.kube/config
				"""
				sh 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'
				sleep 30
				sh 'kubectl get nodes'
				
     //withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
    //sh 'aws eks --region us-west-2 update-kubeconfig --name terraform-eks-demo'
   // }
   //withCredentials([kubeconfigFile(credentialsId: 'kube_config', variable: 'KUBECONFIG')]){
     sh "${tfHome}/terraform output config_map_aws_auth > configmap.yml"
     
    sh 'kubectl apply -f deploy.yml'
    sh 'kubectl apply -f configmap.yml'
    sh 'kubectl apply -f svc.yml'
    sh 'kubectl expose deployment webapp-deploy --type=LoadBalancer'
    sleep 30
    sh 'kubectl get service' 
  
}
}
}
}
