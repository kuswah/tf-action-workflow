# tf-action-workflow

```groovy
pipeline {
    agent any
    
    environment {
        TF_API_TOKEN = credentials('terraform-cloud-token')
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your repository
                // Replace <repository_url> with your actual repository URL
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: '<repository_url>']]])
            }
        }
        
        stage('Terraform Init') {
            steps {
                // Install Terraform
                sh 'curl -LO https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_darwin_amd64.zip'
                sh 'unzip terraform_0.15.0_darwin_amd64.zip'
                sh 'mv terraform /usr/local/bin/'
                
                // Initialize Terraform
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh 'terraform plan'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                // Run Terraform apply
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
```
