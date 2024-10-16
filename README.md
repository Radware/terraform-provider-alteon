<img src="https://www.radware.com/RadwareSite/MediaLibraries/Images/logo.svg" width="300px">

# Terraform Provider for Alteon
The Terraform provider for [Alteon](https://www.radware.com/products/alteon/) enables to automate the provisioning and management of application services on Alteon. 

## Requirements

- Terraform > 1.7.x
- Go v1.22.0 (To build the provider)
- Alteon >= 33.x


# Building the  Provider

Clone repository to: $GOPATH/src/github.com/Radware/terraform-provider-alteon

```
$ mkdir -p $GOPATH/src/github.com/Radware; cd $GOPATH/src/github.com/Radware

$ git clone https://github.com/Radware/terraform-provider-alteon.git

```
Enter the provider directory and build the provider

```
$ cd $GOPATH/src/github.com/Radware/terraform-provider-alteon

$ make build

```

# Using the Provider

If you're building the provider, follow the instructions to install it as a plugin. After placing it into your plugins directory, run terraform init to initialize it.

## Copyright

Copyright 2024 Radware LTD

## License
GNU General Public License v3.0
