package alteon

import (
	"context"
	"strconv"

	radwaregosdk "github.com/Radware/radware_go_sdk"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func data_source_alteon_apply_table() *schema.Resource {
	return &schema.Resource{
		ReadContext: data_source_alteon_apply_table_read,
		Schema: map[string]*schema.Schema{
			"apply_table": &schema.Schema{
				Type:        schema.TypeString,
				Optional:    true,
				Description: "Apply table Received",
			},
		},
	}
}

func data_source_alteon_apply_table_read(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	client := m.(*radwaregosdk.New_Client)
	var diags diag.Diagnostics

	api := "/config/AgApplyTable"

	status, message, err1 := client.GetItem(api, nil, nil)
	detail := "Status Code Received: " + strconv.Itoa(status) + "\nResponse Received: \n" + message

	if err1 != nil {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "REST Apply Status-Get Failed With Error:" + err1.Error() + "\n",
			Detail:   detail + "\nAPI Call Made is:" + api + "\n",
		})
		return diags
	} else if status != 200 {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "REST Apply Status-Get Failed as response code received is: " + strconv.Itoa(status),
			Detail:   detail + "\nAPI Call Made is:\n" + api + "\n",
		})
		return diags
	}
	d.Set("apply_table", message)
	d.SetId("GET for Apply Status") //for state machine
	return diags
}
