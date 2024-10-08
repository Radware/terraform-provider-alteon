terraform {
  required_providers {
    alteon = {
      version = ">=0.0.1"
      source = "Radware/alteon"
    }
  }
}

provider "alteon" {
  username="admin"
  password="radware"
  ip="10.77.55.83" 
   
}

resource "alteon_cli_command" "Test_Cluster" {
  elements {
    agalteonclicommand="/c/slb/filt 3/ena/"    
    }
}

resource "alteon_apply" "Test_apply1" {  
  depends_on = [alteon_cli_command.Test_Cluster]  
}

/*resource "alteon_real_server" "TestServer1" {
  index="Real13"
  elements {
    	ipaddr="13.13.13.203"
      name="Sample-Real"
      timeout=18
      state=2        
    }
}
*/

data "alteon_apply_status_data" "apply_status_code" { 
  depends_on = [alteon_apply.Test_apply1] 
 }
output "apply_status" {
  description = "Apply Status Code"  
  value = [data.alteon_apply_status_data.apply_status_code]
}

data "alteon_apply_table_data" "apply_table" { 
  depends_on = [alteon_apply.Test_apply1] 
 }
output "apply_table" {
  description = "Apply table"  
  value = [data.alteon_apply_table_data.apply_table]
}

/*data "alteon_real_server_data" "TestServer-data" {  
  index="Real13"   
}
output "Real_Server_GET" {
  description = "Real Server GET"  
  value = [data.alteon_real_server_data.TestServer-data]
}
*/
/*
resource "alteon_apply" "Test_apply1" {    
  depends_on = [alteon_real_server.TestServer1]
}

resource "alteon_save" "Test_save" {    
  depends_on = [alteon_apply.Test_apply1]
}

/*resource "alteon_revert_apply" "Test_revert_apply" {    
}*/