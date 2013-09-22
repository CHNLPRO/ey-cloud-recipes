# Chef::Log.info "stack chosen: #{node['engineyard']['environment']['db_stack_name']}"
db_stack(node['engineyard']['environment']['db_stack_name'])
if db_stack == "postgres9"
  postgres_version("9.0")
elsif db_stack == "postgres9_1"
  postgres_version("9.1")
end
postgres_root("/db/postgresql/")