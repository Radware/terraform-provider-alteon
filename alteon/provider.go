package alteon

import (
	"context"
	"strconv"

	radwaregosdk "github.com/Radware/radware_go_sdk"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

// Provider -
func Provider() *schema.Provider {
	return &schema.Provider{
		Schema: map[string]*schema.Schema{
			"username": &schema.Schema{
				Type:        schema.TypeString,
				Optional:    true,
				DefaultFunc: schema.EnvDefaultFunc("ALTEON_USERNAME", nil),
				Description: "Alteon Username.",
			},
			"password": &schema.Schema{
				Type:        schema.TypeString,
				Optional:    true,
				Sensitive:   true,
				DefaultFunc: schema.EnvDefaultFunc("ALTEON_PASSWORD", nil),
				Description: "Alteon Password.",
			},
			"ip": &schema.Schema{
				Type:        schema.TypeString,
				Optional:    true,
				Sensitive:   true,
				DefaultFunc: schema.EnvDefaultFunc("ALTEON_IP", nil),
				Description: "Management IP of Alteon.",
			},
		},
		ResourcesMap: map[string]*schema.Resource{
			"alteon_real_server":        resource_alteon_real_server(),
			"alteon_server_group":       resource_alteon_server_group(),
			"alteon_cli_command":        resource_alteon_cli_command(),
			"alteon_apply":              resource_alteon_apply(),
			"alteon_save":               resource_alteon_save(),
			"alteon_revert":             resource_alteon_revert(),
			"alteon_revert_apply":       resource_alteon_revert_apply(),
			"alteon_virtual_server":     resource_alteon_virtual_server(),
			"alteon_virtual_service":    resource_alteon_virtual_service(),
			"alteon_ssl_policy":         resource_alteon_ssl_policy(),
			"alteon_http2_policy":       resource_alteon_http2_policy(),
			"alteon_https_health_check": resource_alteon_https_health_check(),
		},
		DataSourcesMap: map[string]*schema.Resource{
			//"real_server": dataSourceRealServer(),
			"alteon_real_server_data":        data_source_alteon_real_server(),
			"alteon_server_group_data":       data_source_alteon_server_group(),
			"alteon_virtual_server_data":     data_source_alteon_virtual_server(),
			"alteon_https_health_check_data": data_source_alteon_https_health_check(),
			"alteon_ssl_policy_data":         data_source_alteon_ssl_policy(),
			"alteon_http2_policy_data":       data_source_alteon_http2_policy(),
			"alteon_virtual_service_data":    data_source_alteon_virtual_service(),
			"alteon_apply_status_data":       data_source_alteon_apply_status(),
			"alteon_apply_table_data":        data_source_alteon_apply_table(),
		},
		ConfigureContextFunc: providerConfigure,
	}
}

func providerConfigure(ctx context.Context, d *schema.ResourceData) (interface{}, diag.Diagnostics) {
	username := d.Get("username").(string)
	password := d.Get("password").(string)
	host := d.Get("ip").(string)

	// Warning or errors can be collected in a slice type
	var diags diag.Diagnostics

	/*
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Warning,
			Summary:  "Warning Message Summary",
			Detail:   "This is the detailed warning message from providerConfigure",
		})*/

	if (username != "") && (password != "") {
		client, status, message, err := radwaregosdk.Login("ALTEON", host, username, password)
		//client.HostIP = host
		detail := strconv.Itoa(status) + message

		if err != nil {
			diags = append(diags, diag.Diagnostic{
				Severity: diag.Error,
				Summary:  "Unable to connect to Alteon." + detail + err.Error(),
				Detail:   detail + err.Error(),
			})
			return nil, diags
		}

		if client == nil {
			diags = append(diags, diag.Diagnostic{
				Severity: diag.Error,
				Summary:  "Authentication Failed" + detail,
				Detail:   detail,
			})
			return nil, diags
		}

		return client, diags
	}

	return 1, diags
}
