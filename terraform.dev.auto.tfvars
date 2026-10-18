subscription_id  = "e9b8a2e4-959a-4222-92b0-33f67ce457e7"
project          = "cloudx-2026q3-finaltask"
environment      = "dev"
owner            = "alex-doka"
cost_center      = "learning"
primary_location = "polandcentral"

app_service_plans = {
  plc = {
    location = "polandcentral"
    sku_name = "B1"
  }
  swc = {
    location = "swedencentral"
    sku_name = "B1"
  }
}

sql_database_sku         = "Basic"
sql_database_max_size_gb = 2
