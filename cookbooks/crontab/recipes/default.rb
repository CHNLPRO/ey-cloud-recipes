node[:applications].each do |app_name,data|
  cron "cleanup-uploads" do
    user node[:owner_name]
    minute "0"
    hour "*"
    day "*"
    month "*"
    weekday "*"
    command "find /data/#{app_name}/current/public/uploads/tmp -type d -cmin +60 -print0 | xargs -0 rm -r"
    action :create
  end

  cron "cleanup-resque-workers" do
    user node[:owner_name]
    minute "*/30"
    hour "*"
    day "*"
    month "*"
    weekday "*"
    command "/data/#{app_name}/current/script/kill-stuck-jobs.sh"
    action :create
  end
end

cron "cleanup-openuri-files" do
  user node[:owner_name]
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "find /tmp -name 'open-uri*' -cmin +60 -print0 | xargs -0 rm"
  action :create
end
