trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

variables:
  azureServiceConnection: 'azure-free-conn'

stages:
  - stage: Network_Deploy
    displayName: 'Deploy Only Network'
    jobs:
      - job: Terraform_Apply
        steps:
          - task: AzureCLI@2
            displayName: 'Install Terraform and Apply Network'
            inputs:
              azureSubscription: '$(azureServiceConnection)'
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                # 1. டெராஃபார்மை இன்ஸ்டால் செய்கிறோம்
                sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
                wget -O- https://hashicorp.com | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt-get update && sudo apt-get install terraform -y

                # 2. உங்கள் ஃபைல் இருக்கும் ஃபோல்டருக்குள் நுழைகிறோம் (இங்கு உங்கள் ஃபோல்டர் பெயரை மாற்றவும்)
                cd networking

                # 3. டெராஃபார்மை இயக்குகிறோம்
                terraform init
                terraform apply -auto-approve
