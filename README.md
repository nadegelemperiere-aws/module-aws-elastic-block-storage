![Technogix logo](docs/imgs/logo.png)       

# Technogix s3 module

## About The Project

This project contains all the infrastructure as code (IaC) to deploy a s3 bucket in AWS

### Built With

* [Terraform 1.1.3](https://www.terraform.io/docs/index.html)
* [Terraform provider for aws 3.71.0](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Getting Started

### Prerequisites

S3 bucket accesses are logged into another s3 bucket. In order to collect access logs, the logging s3 bucket shall have been declared (using this module for example) 

### Configuration

To use this module in a wider terraform deployment, add the module to a terraform deployment using the following module:

>**module** "bucket" {
>
>  **source**            = "git::codecommit::eu-west-1://technogix-module-s3?ref=*this module version*"
> 
>  **project**           = *the project to which the bucket belongs* 
> 
>  **module**            = *the project module to which the bucket belongs* 
> 
>  **email**             = *the email of the person responsible for the bucket maintainance* 
> 
>  **environment**       = *the type of environment to which the bucket contributes (prod, preprod, staging, sandbox, ...)* 
> 
>  **git_version**       = *the version of the deployment that uses the bucket* 
>
>  **private**           = *True if the bucket public accesses shall be blocked, false otherwise*
> 
>  **name**              = *The bucket name*
>
>  **access_logging**    = *The identifier of the bucket to use for access logs (optional)*
>
>  **account**           = *AWS account to allow access to root by default*
>
>  **service_principal** = *Technical IAM account used for automation that shall be able to access the bucket*
> 
>  **lifecycles**     = [ *list of the lifecycles to apply (optional)*
>
>   {
>
>   **identifier** = *Lifecycle identifier*
>
>   **prefix**     = *Logs prefix to which the lifecycle applies"
>
>   **transitions** = [
>     { 
>       
>    **days**            = *Number of storage days after which transition occurs*
>
>    **storage_class**   = *Target storage type for transition*
>
>     }
>
>   ]
>
>   **expiration** = {
>
>    **days** = *Number of days after which stored objects are destroyed*
>
>   }
>
>   **noncurrent_version_transitions** : []
>
>   **noncurrent_version_expiration**  : {}
>
>  }
>
>  ]
>
>  **rights**         : {
>
>   [
>
>    {
>
>    **description** = *Name of the set of rules, type AllowSomebodyToDoSomething*
>
>    **actions**     = [ *List of allowed s3 actions, like "s3:PutObject" for example* ]
>
>    **principal**   = {
>
>    **aws**            = [ *list of roles and/or iam users that are allowed bucket access* ]
>
>    **services**       = [ *List of AWS services that are allowed bucket access* ]
>
>    }
>
>    **content**      = *True if the rights does not concern the bucket itself, but its content*
>
>    }
>
>    ]
>
>    }
>
>  }
>
>}


### Usage

The environment variable AWS_PROFILE shall be set to a sso profile that is registered in the AWS cli configuration with rights to access the module code commit repository (see [codecommit documentation](https://pypi.org/project/git-remote-codecommit/))

```
export AWS_PROFILE=developer-<account>
``` 

The module is deployed alongside the module other terraform components, using the classic command lines :

```
terraform init ...
terraform plan ...
terraform apply ...
``` 

## Detailed design

![Module architecture](docs/imgs/module.png)       

## Testing

### Tested With

* [Python 3.11.0a3](https://www.python.org)
* [Robotframework 4.1.3](http://robotframework.org/)
* [Boto3 1.20.34](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)

### Strategy

The test strategy consists in terraforming test infrastructures based on the s3 module and check that the resulting AWS infrastructure matches what is expected.
The tests currently contains 1 test :

1 - A test to check the capability to create multiple s3 buckets

The tests cases :
* Apply terraform to deploy the test infrastructure
* Use specific keywords to model the expected infrastructure in the boto3 format. 
* Use shared cloudwatch keywords to check that the boto3 input matches the expected infrastructure

NB : It is not possible to completely specify the expected infrastructure, since some of the value returned by boto are not known before apply. The comparaison functions checks that all the specified data keys are present in the output, leaving alone the other undefined keys.

## Roadmap

N.A.

## Contributing

N.A.

## License

This code is distributed under the [MIT](license). Check the [LICENSE](LICENSE) file for more information

## Contact

Nadege LEMPERIERE - nadege.lemperiere@technogix.io

Project Link: [https://eu-west-1.console.aws.amazon.com/codesuite/codecommit/repositories/technogix-module-s3/browse?region=eu-west-1](https://eu-west-1.console.aws.amazon.com/codesuite/codecommit/repositories/technogix-module-s3/browse?region=eu-west-1)

## Acknowledgments

N.A.
