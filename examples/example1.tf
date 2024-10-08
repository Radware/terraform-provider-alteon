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

/*data "alteon_real_server_data" "TestServer-data" {    
  index="Real13"   
}

/*data "alteon_server_group_data" "TestGroup-data" {    
  index="grp-table"
  //realserverindex="single-Table1"
}


data "alteon_apply_status_cluster_data" "ApplyStatus-data" {  
  //depends_on = [null_resource.wait_time]   
}*/

/*data "alteon_virtual_server_data" "VirtualServer-data" {  
  //clustername="dzACMCluster2"   
  index="Virt1-1" 
}*/

/*data "alteon_https_health_check_data" "HttpsHealthCheck-data" {    
  index="hc1" 
}*/

/*data "alteon_ssl_policy_data" "SslPolicy-data" {     
  nameidindex="Policy1" 
}*/

/*data "alteon_http2_policy_data" "Http2Policy-data" {     
  nameidindex="samplepolicy"
}*/

/*data "alteon_virtual_service_data" "VirtualService-data" {     
  servindex="Virt1-1"
  index=2
}
 
output "Real_Server_GET" {
  description = "Real Server GET"  
  value = [data.alteon_real_server_data.TestServer-data]
}


/*resource "alteon_apply" "Test_apply1" {    
  /*lifecycle {    
    replace_triggered_by = [
      alteon_real_server.TestServer1
    ]
  }
  depends_on = [alteon_real_server.TestServer1,alteon_real_server.TestServer2]
  //depends_on = [alteon_server_group.Server-Grp1]
}

/*resource "alteon_revert_apply" "Test_revert_apply" {    
}

/*resource "alteon_save" "Test_save" {    
  depends_on = [alteon_apply.Test_apply1]
}*/

resource "alteon_revert" "Test_revert" {  
}

/*resource "alteon_cli_command" "Test_Cluster" {  
  elements {
    agalteonclicommand="/c/slb/filt 3/ena/"    
    }
}*/

/*resource "alteon_real_server" "TestServer1" {    
  index="Multi-Real1"
  elements {
    	ipaddr="111.1.1.20"
      name="maxsizeid"
      timeout=22
      state=2
      weight=18    
    }
    elements_2 {
    	proxy=2
      ldapwr=2    
      fasthealthcheck=1
      subdmac=2
    }
    elements_3 {
    	criticalconnthrsh=85
      highconnthrsh=75    
    }
}
resource "alteon_real_server" "TestServer2" {    
  index="single-Table1"
  elements {
    	ipaddr="11.11.11.201"
      name="SingleTableReal"
      timeout=12
      state=2
      //weight=data.alteon_real_server_data.TestServer-data.weight   
    }
}

resource "alteon_real_server" "TestServer3" {    
  index="Real13"
  elements {
    	ipaddr="13.13.13.203"
      name="Sample-Real"
      timeout=18
      state=2        
    }
}

/*resource "alteon_real_server" "TestServer4" {    
  index="Real4"
  elements {
    	ipaddr="14.14.14.204"
      name="Real4"
      timeout=18
      state=2
      //weight=data.alteon_real_server_data.TestServer-data.weight   
    }
}

/*resource "alteon_server_group" "Server-Grp1" {  
  index="grp-table"
  elements {
    name="Group-Update"
    addserver="Real4"    
    healthcheckurl="content.html"  
    healthchecklayer=3
    metric=1
    //backupserver="Grp-bkup-name"    
    }
  //depends_on = [alteon_real_server.TestServer4]
}

resource "alteon_virtual_server" "TestVirtualServer1" {  
  index="Virt1-1"
  elements {
    	virtserveripaddress="10.10.10.10"
      virtserverstate=2
      virtserverdname="virtual-Server-Domain-Update"
      //virtserverweight=data.alteon_virtual_server_data.VirtualServer-data.virtserverweight
      virtservernat="14.24.4.5"
      //virtserverbwmcontract=1022
      virtserveravail=2
      virtservervname="VirtualServerVName"
    }
  //depends_on = [alteon_server_group.LabServers]
}

/*resource "alteon_ssl_policy" "TestSslPolicy" {  
  nameidindex="Policy1"
  elements {
    	name="testsslPolicy-Update"      
      adminstatus=1
      //bessl=2
      fesslv3version=1
      passinfocomply=2
    }  
}

resource "alteon_http2_policy" "TestHttp2Policy" {  
  nameidindex="samplepolicy"
  elements {
    	name="testHttp2Policy-Update"      
      adminstatus=1
      backendstatus=1
      backendhpacksize="small"
      backendstreams=4
      streams=4
      hpacksize="small"
    }  
}
resource "alteon_https_health_check" "TestAdvhcHttp" {  
  index="hc1"
  elements {
    	name="HC_TEST-Update"      
      dport=3
      ipver=1
      hostname="advHChostName"
      invert=1
      authlevel=2
    }  
}

resource "alteon_virtual_service" "TestVirtualService" {  
  servindex="Virt1-1"
  index=1
  elements {
    	virtport=80
      realport=80
      dbind=2
      udpbalance=3
      pbind=3
      //cookiemode=3
    }
    elements_2 {
      connmgtstatus=2
      connmgttimeout=12
      cachepol="Virtservice secondtable-Update"
      servurlchangstatus=1
      servurlchanghosttype=1
    }
    elements_3 {
      servurlchanghostname="thirdtablhostname"
      servurlchangpathtype=1
      servurlchangpathmatch="UrlPathname"
    }
    elements_4 {
      servurlchangnewpgname="New-url-Page-Name"
      servpathhidehosttype=1
      servpathhidehostname="hst-nam-4thTable"
      servtextrepstatus=1
    }
    elements_5 {
      servtextrepmatchtext="Text-match-fifth-table-Update"
      udpage=1
      alwayson=1
    }
    elements_6 {
      hname="hstnamesixthtable"
      direct=1
    }
    elements_7 {
      realgroup="grp-nam-seventh-table-Update"
      sessionmirror=1
    }  
  depends_on = [alteon_virtual_server.TestVirtualServer1]
}

resource "alteon_virtual_service" "TestVirtualService2" {  
  servindex="Virt1-1"
  index=2
  elements {
    	virtport=53
      realport=53
      //dbind=3
      sideband="name-sideband-test-Update"
    }
  depends_on = [alteon_virtual_server.TestVirtualServer1]
}*/
