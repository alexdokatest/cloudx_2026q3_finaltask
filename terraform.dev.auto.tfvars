subscription_id  = "e9b8a2e4-959a-4222-92b0-33f67ce457e7"
project          = "cloudx-2026q3-finaltask"
environment      = "dev"
owner            = "alex-doka"
cost_center      = "learning"
primary_location = "polandcentral"

app_service_plans = {
  plc = {
    location = "polandcentral"
    sku_name = "S1"
  }
  swc = {
    location = "swedencentral"
    sku_name = "S1"
  }
}

sql_database_sku         = "Basic"
sql_database_max_size_gb = 2

key_vault_name_prefix = "kv-cloudx"
key_vault_sku_name    = "standard"

sql_connection_secret_name = "alex-doka-1"
sql_password_version       = 1

traffic_manager_routing_method = "Performance"
traffic_manager_dns_ttl        = 60
