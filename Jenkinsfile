//This is parameterized build so create parameter name as action and type as choice with 2 option as apply and destroy
pipeline {
    agent any
    
    environment {
        TF_TOKEN_app_terraform_io = credentials('terraform-cloud-token')
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mevijays/tf-action-workflow.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                // Install Terraform
                sh 'curl -LO https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_amd64.zip'
                sh 'unzip terraform_1.6.5_linux_amd64.zip'
            // Initialize Terraform
                sh './terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh './terraform plan'
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression { params.action == "apply" }
            }
            steps {
                // Run Terraform apply
                sh './terraform apply -auto-approve'
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.action == "destroy" }
            }
            steps {
                // Run Terraform destroy
                sh './terraform apply --destroy --auto-approve'
            }
        }
    }
}
