terraform {
  required_providers {
    alteon = {
      version = ">=0.0.1"
      source = "Radware/alteon"
    }
  }
}

provider "cybercontroller" {
  username="radware"
  password="radware"
  ip="10.171.101.97" 
   
}

data "alteon_real_server_data" "TestServer-data" {  
  index="Real13"   
}
output "Real_Server_GET" {
  description = "Real Server GET"  
  value = [data.alteon_real_server_data.TestServer-data]
}
