variable "rgs"{
    
}
resource "azurerm_resource_group" "rg-block"{

    for_each = var.rgs
    name = each.key
    location = each.value.location
}