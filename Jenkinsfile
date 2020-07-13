node {
stage('SCM Checkout')
{
git 'https://github.com/tejasrik/e2e.git'
}
 /*stage('Compile-Package'){
      // Get maven home path
     //def mvnHome =  tool name: 'maven3.6.3', type: 'maven' 
     //batlabel "${mvnHome}/bin/mvn package"
  // bat "${mvnHome}/bin/mvn clean package"
 // bat label: '', script: "${mvnHome}/bin/mvn clean package"
         def mavenHome = tool name:"Maven-3.6.3",type: "maven"
         
         def mavenCMD= "${mavenHome}/bin/mvn"
         sh "${mavenCMD} clean package"
    }
    
   
    stage('publish docker'){
       sh  'docker build -t tejasrik/devopspipeline .'
       sh 'docker login -u tejasrik -p Tejasri@6523'
       sh'docker push tejasrik/devopspipeline'
       sh'docker run -d tejasrik/devopspipeline'
    }	
	
	
/*stage("Terraform init/plan/apply"){
	

     withCredentials([string(credentialsId: 'aws-access-id', variable: 'AWS_ACCESS_KEY_ID'),
		      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]){
   
	sh "terraform destroy -auto-approve"
     }
}
}*/

/*stage("Terraform init/plan/apply"){
	

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
				sh ' chown $(id -u):$(id -g) $HOME/.kube/config'
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
}*/



	stage ('Deployment to k8s through ansible') {
        print 'Deployment through ansible'
		withCredentials([string(credentialsId: 'docker.pem', variable: 'docker.pem')]{
        sh '''
      scp -i "docker.pem" /home/ubuntu/.ssh/id_rsa ubuntu@3.226.243.233:~/.ssh/.
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/ubuntu/hosts -u ubuntu --private-key=~/.ssh/id_rsa ansible.yaml      
          '''}
    } 
				}				
