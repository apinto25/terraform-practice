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

## **Specifying the provider**

How to specify the version of the provider:
* `>=1.0` Greater than or equal to the version.
* `<=1.0` Less than or equal to the version.
* `~>2.0` Any version in the 2.X range
* `>=2.10, <=2.30` Any version between 2.10 and 2.30

```
terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = ~>2.0
        }
    }
}
```

When changing the version of the provider after doing the `terraform init`, terraform will re-select the first version defined. To override the version run:

    terraform init -upgrade

## **Attributes**
Terraform allows to output the attribute from a resource as an output value. Output attributes can also be used as an input to other resources that will be created using terraform.

```
output "<output_name>" {
    value = <resource>.<resource_identifier>.<attribute>
}
```

## **Variables**
Repeated static values can create more work in the future, to avoid repeating values we can create terraform variables that are set only once and use them in all the files where the value is needed. Variables are defined as follows:

```
variable "<variable_name>" {
    default = "<variable_value>"
}
```

The variables defined with a default value in the variables.tf file can be also defined by command line when running `terraform plan` or `terraform apply`:

    terraform plan -var="<variable_name>=<variable_value>"

When the variable has not a default value, the value will be required a  after running terraform plan or apply.

When using different environments is recommended to define the variables in .tfvars files, in those fles we define the value of the variables and then select which of the files will be used when running the terraform plan or apply.

Variable types allows to add a constraint about the values that the variable can have. For example, to define a variable of type number:

```
variable "<variable_name>" {
    type = "number"
}
```

The [count](https://www.terraform.io/docs/language/meta-arguments/count.html#basic-syntax) meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

In blocks where count is set, the name of the resources can be differentiate one from the others by adding the count.index attribute by instantiating the name of the resource, for example:

```
resource "<resource_type>" "<resource_name>" {
    name  = "<variable_name>.${count.index}"
    count = 3
    path  = "/system/"
}
```

Each of the created resources will be named as the variable name followed by the number of the count in each iteration as follows:
1. <variable_name>0
2. <variable_name>1
3. <variable_name>2

If it is required for the resources to be named with specific names we can define a list of values that contains each of the names for the resources, for example:


```
variable "<variable_name>" {
    type    = list
    default = ["name1", "name2", "name3"] 
}

resource "<resource_type>" "<resource_name>" {
    name  = var.<variable_name>[count.index]
    count = 3
    path  = "/system/"
}
```
