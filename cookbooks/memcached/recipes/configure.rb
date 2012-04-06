#
# Cookbook Name:: memcached
# Recipe:: configure
#

if node[:instance_role] == 'solo'
  template "/data/chnl/shared/config/memcached.yml" do
    source "memcached.yml.erb"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
        :app_name     => 'chnl',
    })
  end
else
  template "/data/chnl/shared/config/memcached.yml" do
    source "memcached.yml.erb"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
        :app_name     => 'chnl',
        :server_names => Array(node[:members]).sort
    })
  end
end
