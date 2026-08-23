resource "azurerm_public_ip" "appgw_pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = var.waf_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  policy_settings {
    enabled            = true
    mode               = var.waf_mode
    request_body_check = true
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.waf_policy.id
  tags                = var.tags

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_port {
    name = "https-port"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  # Backend Pool 1: Monolithic App
  backend_address_pool {
    name = "backend-pool-monolithic"
  }

  # Backend Pool 2: Supporting App
  backend_address_pool {
    name = "backend-pool-supporting"
  }

  # HTTP Settings for Monolithic App
  backend_http_settings {
    name                  = "http-settings-monolithic"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  # HTTP Settings for Supporting App
  backend_http_settings {
    name                  = "http-settings-supporting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  # HTTP Listener
  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  # URL Path Map for routing to Monolithic App (default) and Supporting App (/supporting/*)
  url_path_map {
    name                               = "url-path-map"
    default_backend_address_pool_name   = "backend-pool-monolithic"
    default_backend_http_settings_name = "http-settings-monolithic"

    path_rule {
      name                       = "supporting-app-rule"
      paths                      = ["/supporting/*", "/api/supporting/*"]
      backend_address_pool_name   = "backend-pool-supporting"
      backend_http_settings_name = "http-settings-supporting"
    }
  }

  # Routing Rule using Path-based routing
  request_routing_rule {
    name               = "routing-rule-path-based"
    rule_type          = "PathBasedRouting"
    http_listener_name = "http-listener"
    url_path_map_name  = "url-path-map"
    priority           = 100
  }
}
