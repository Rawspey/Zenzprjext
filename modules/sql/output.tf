output "sql_server_name" {
  description = "The name of the SQL Server."
  value       = azurerm_sql_server.zenpaysqlserver.name
}

output "sql_db_name" {
  description = "The name of the SQL Database."
  value       = azurerm_sql_database.zenpaysqldb.name
}
