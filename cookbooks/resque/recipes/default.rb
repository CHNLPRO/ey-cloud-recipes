#
# Cookbook Name:: resque
# Recipe:: default
#

execute "install resque gem" do
  command "gem install resque redis redis-namespace yajl-ruby -r"
  not_if { "gem list | grep resque" }
end

worker_count = {
  'm1.small'  => 2  ,
  'm1.medium' => 8  ,
  'm1.large'  => 12 ,
  'c1.medium' => 3  ,
  'c1.xlarge' => 8  ,
}[node[:ec2][:instance_type]] || 4

if %w{app}.include?(node[:instance_role])
  worker_count /= 2
end

node[:applications].each do |app, data|

  template "/etc/monit.d/resque_#{app}.monitrc" do
    owner 'root'
    group 'root'
    mode 0644
    source "monitrc.conf.erb"
    variables({
      :num_workers => worker_count,
      :app_name    => app,
      :rails_env   => node[:environment][:framework_env]
    })
  end

  worker_count.times do |count|
    template "/data/#{app}/shared/config/resque_#{count}.conf" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      source "resque_wildcard.conf.erb"
    end
  end
end

execute "ensure-resque-is-setup-with-monit" do
  epic_fail true
  command "monit reload"
end
