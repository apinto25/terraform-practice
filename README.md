# **Terraform Practice**

Terraform practice scripts to deploy IaC using AWS services.

## **Terraform concepts**

* **Provider:** plugin that allows to interact with remote systems or cloud platforms.
* **Resource:** describes one or more infrastructure objects (virtual networks, compute instances, among others)

### **Terraform commands**

* `terraform init` -> Download all the plugins associated to the provider we are using to interact with it. Everytime we add, modify or delete a provider terraform init is required.
* `terraform plan` -> creates an execution plan of the, it let us know the changes that will be performed, it also shows if there is an error with the terraform files.
* `terraform apply` -> applies the changes required to reach the desired state of the configuration.
* `terraform destroy` -> allows to destroy all the resources that are created within the folder. To destroy an specific resource use the flag `-target` with the name of the resource to be deleted.

        terraform destroy -target <resource_type>.<resource_name>

    To delete a the aws ec2 resource named myec2 run:

        terraform destroy -target aws_instance.myec2

* `terraform refresh` -> updates the current state of the real infrastructure in the terraform state file.

## **Terraform State Files**

Terraform state files store the state of the infrastructure that s beign created at a state file. This file tracks the resources created, modified ot deleted. It is useful for future operations like init, plan or destroy

This file also contains detailed information of the resources created, depending of each one it will store different data. So it is *really* important not to delete this file or manually edit the content inside

## **Desider and Current State**

Terraform's primary function is to create, modify and destroy infrastructure resources to match the desired state described in a Terraform configuration.

The **current state** is the actual state of the resource that is currently deployed.

Terraform tries to ensure that the deployed infrastructure is based on the desired state. If there is a difference between the two, terraform plan presents a description of the necessary changes to achieve the desired state.