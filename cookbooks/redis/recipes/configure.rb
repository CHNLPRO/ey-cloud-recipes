#
# Cookbook Name:: redis
# Recipe:: configure
#

if node[:instance_role] == 'solo'
  redis_host = node[:fqdn]
else
  redis_host = node.engineyard.environment.instances.detect do |instance|
    instance[:role] == 'db_master'
  end[:private_hostname]
end

template "/data/chnl/shared/config/redis.yml" do
  source "redis.yml.erb"
  owner node[:owner_name]
  group node[:owner_name]
  mode 0644
  variables({
    :rails_env => node[:environment][:framework_env],
    :server    => redis_host,
    :port      => node[:redis][:bindport],
  })
end
