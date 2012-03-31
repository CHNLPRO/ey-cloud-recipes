#
# Cookbook Name:: memcached
# Recipe:: default
#

enable_package "net-misc/memcached" do
  version "1.4.5"
end

package "net-misc/memcached" do
  version "1.4.5"
  action :install
end

template "/etc/conf.d/memcached" do
  owner 'root'
  group 'root'
  mode 0644
  source "memcached.erb"
  variables :memusage => 64,
            :port     => 11211
end
