# candle_cpu_scott

## install Azure Cli 
```
$ curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### login in to Azure 
```
$ az login 

# if above not working run:  
$ az login --use-device-code
```
```
$ az account set --subscription <subscription_ID>
# check if the correct account is set.
$ az account show 
```

### Create an service principle with the following details:
* AppID 
* password 
* tenant information 

```
$ az ad sp create-for-rbac -n "candle_rust_vm_principal"
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli

$    az ad sp create-for-rbac --name “GitHub-vms-candle” --role contributor \
                            --scopes /subscriptions/<subscription_ID>/resourceGroups/<Resource_Group_Name>\
                            --sdk-auth
```

### Create an Azure Key Vault
You will store your GitHub PAT here so that it can later be retrieved by the VM.
```
$ az keyvault create --name candel-vms --resource-group githubVM --location eastus
$ az keyvault secret set --vault-name candel-vms --name "GitHubPAT" --value $GITHUB_PAT
```
Replace $GITHUB_PAT with the value of the PAT created earlier

### Assign an identity with permissions for Key Vault
Now that the key vault is created, you need to create an identity and then allow resources in the resource group to be able to access it. You must give this identity a name, in this case we use GitHubVMs. Note this name will be used in other steps.

```
$ az identity create --name GitHubVMs --resource-group githubVM --location eastus

```
Capture the Principal ID which will be used for the value for --object-id later. You can retrieve it again by using:

```
$ az identity show --name GitHubVMs --resource-group githubVM
```

Use the object id to set the policy, replace $OBJECT_ID with the one you found in the previous command:
```
$ az keyvault set-policy --name candel-vms --object-id 301d22a1-562e-4987-9f77-64d5beae8e8d --secret-permissions get
```

### Verify you can get the PAT with the following command:
```
az keyvault secret show --name "GitHubPAT" --vault-name candel-vms --query value -o tsv
```


### Provide a role to VMs
Assign a role to the VMs so that they have enough permissions to write the image when getting created. Start by finding the principalId which will then be needed for the next step:

```
az identity show --name GitHubVMs --resource-group githubVM --query principalId
```

With the principalId you can assign it to the VMs now:

```
az role assignment create --assignee <principal_ID> --role Contributor --resource-group githubVM
```


### Trigger the create image run
Now you are ready to create the image. Run it manually and make sure it works correctly. If succesful, an image will be created for you which you can query with the following command:
```
az image list --resource-group githubVM --output table
```


### choice the VM size 

```
 az vm list-sizes --location eastus --query "[].name" -o tsv
```

```
az vm list-sizes --location eastus --query "[].name" -o tsv | grep A100
```

```
az vm image list-skus --location eastus --publisher nvidia --offer nvidia_hpc_sdk_vmi
```

find out the image-source in [here](https://az-vm-image.info/?cmd=--all)


```
az vm image list --architecture x64 --publisher nvidia --all --output table
```

check out the purchase plan
```
az vm image show --location eastus --urn nvidia:nvidia_hpc_sdk_vmi:nvidia_hpc_sdk_vmi_23_03_0_gen2:23.03.0
```




## create the github release

```
GITHUB_TOKEN="your_github_token"
REPO="username/repo"  # Replace with your GitHub username and repo name
TAG="v1.0.0"          # Replace with your tag version
RELEASE_NAME="Release Title"

```

