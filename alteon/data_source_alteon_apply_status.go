package alteon

import (
	"context"
	"encoding/json"
	"strconv"

	radwaregosdk "github.com/Radware/radware_go_sdk"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func data_source_alteon_apply_status() *schema.Resource {
	return &schema.Resource{
		ReadContext: data_source_alteon_apply_status_read,
		Schema: map[string]*schema.Schema{
			"apply_status_code": &schema.Schema{
				Type:        schema.TypeInt,
				Optional:    true,
				Description: "Apply Status Code Received",
			},
		},
	}
}

func data_source_alteon_apply_status_read(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	client := m.(*radwaregosdk.New_Client)
	var diags diag.Diagnostics

	api := "/config?prop=agApplyConfig"

	status, message, err1 := client.GetItem(api, nil, nil)
	detail := "Status Code Received: " + strconv.Itoa(status) + "\nResponse Received: \n" + message

	if err1 != nil {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "REST Apply-GetItem Failed With Error:" + err1.Error() + "\n",
			Detail:   detail + "\nAPI Call Made is:" + api + "\n",
		})
		return diags
	} else if status != 200 {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "REST Apply-GetItem Failed as response code received is: " + strconv.Itoa(status),
			Detail:   detail + "\nAPI Call Made is:\n" + api + "\n",
		})
		return diags

	} else { //for processing response from Alteon added to CC
		resp_body_alteon := make(map[string]int)
		json.Unmarshal([]byte(message), &resp_body_alteon)
		//var resp_list_alteon []interface{}
		var status_code int
		for _, code := range resp_body_alteon {
			status_code = code
		}
		d.Set("apply_status_code", status_code)
	}
	d.SetId("Read for Apply Status") //for state machine

	return diags
}
