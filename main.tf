module "transit_azure" {
  source  = "terraform-aviatrix-modules/azure-transit/aviatrix"
  version = "2.0.0" #Please check compatitbility version of controller, Terraform and Aviatrix provider
  cidr = var.transit_cidr
  region = var.transit_region
  account = var.azure_acct
  insane_mode = var.insane_mode 
  instance_size = var.transit_instance_size # Insane mode Requires Standard_D3_v2 atleast
  ha_gw = var.transit_ha
  name = var.transit_name
  #connected_transit = true
  #learned_cidr_approval = false
  #active_mesh = true
  #enable_segmentation = false   
}

module "spoke_azure_1" {
  source  = "terraform-aviatrix-modules/azure-spoke/aviatrix"
  version = "2.0.0" #Please check compatitbility version of controller, Terraform and Aviatrix provider
  name = var.spoke1_name
  cidr = var.spoke1_cidr
  region = var.spoke1_region
  account = var.azure_acct
  insane_mode = var.insane_mode
  ha_gw = var.spoke1_ha
  instance_size = var.spoke1_instance_size # Insane mode Requires Standard_D3_v2 atleast
  #attached = true
  transit_gw = module.transit_azure.transit_gateway.id #make sure the module name matches
  #transit_gw = var.transit_gw 
  #active_mesh = true
  #security_domain = "sec_domain_name"  #need to be attached and segmentation enabled on Transit
}

