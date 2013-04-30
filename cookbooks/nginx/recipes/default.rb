execute 'nginx-reload-config' do
  command "sudo /etc/init.d/nginx reload"
  action :nothing
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
    notifies :run, "execute[nginx-reload-config]"
  end
end

