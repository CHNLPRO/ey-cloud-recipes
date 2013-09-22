service "ngnix" do
  supports :reload => true
  action [ :reload ]
  reload_command "sudo /etc/init.d/nginx reload"
end

node[:applications].each do |app_name,data|

  domain   = data["vhosts"]
  domain &&= domain[0]
  domain &&= domain["name"]
  domain ||= "chnl.it"

  template "/data/nginx/servers/#{app_name}/custom.conf" do
    owner  node[:owner_name]
    group  node[:owner_name]
    mode   0644
    source "custom.conf.erb"
    variables(:domain   => domain)
    notifies :reload, "service[nginx]", :immeditately
  end
end

