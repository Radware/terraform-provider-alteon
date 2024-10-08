terraform {
  required_providers {
    alteon = {
      version = ">=0.0.1"
      source = "Radware/alteon"
    }
  }
}

provider "alteon" {
  username="radware"
  password="radware"
  ip="10.171.101.97" 
   
}
resource "alteon_real_server" "TestServer1" {
  index="Real13"
  elements {
    	ipaddr="13.13.13.203"
      name="Sample-Real"
      timeout=18
      state=2        
    }
}

