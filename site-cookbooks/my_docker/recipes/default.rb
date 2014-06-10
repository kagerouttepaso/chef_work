#
# Cookbook Name:: my_docker
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
support_Mail_Address = node[:my_docker][:upport_mail_address];
hostname             = node["fqdn"];
dockerfiles_Dir      = node[:my_docker][:data_dir];

directory dockerfiles_Dir do
  owner  "root"
  group  "docker"
  mode   "755"
  action :create
end

gitlab_service_name = "gitlab";
nginx_service_name  = "nginx";
services = [nginx_service_name, gitlab_service_name];

services.each do |s|
  docker_container s do
    action :stop
  end
  docker_container s do
    action :remove
  end
  execute "remove" + s do
    command "if [ -f /var/run/" + s + ".cid ]; then rm /var/run/" + s + ".cid; fi"
  end

end

#gitlab
gitlab_dir          = dockerfiles_Dir + "/" + gitlab_service_name;

simple_iptables_rule gitlab_service_name + "_iptable" do
  rule [
    "--proto tcp --dport 10022",
  ]
  jump "ACCEPT"
end

docker_container gitlab_service_name do
  image          "sameersbn/gitlab"
  detach         true
  container_name gitlab_service_name
  action         :run
  init_type      false
  port [
    "10022:22",
  ]
  env [
    "NGINX_MAX_UPLOAD_SIZE=512m",
    "GITLAB_HOST=" + hostname,
    "GITLAB_SUPPORT=" + support_Mail_Address,
    "GITLAB_BACKUPS=daily",
    "GITLAB_RELATIVE_URL_ROOT=/gitlab",
    "GITLAB_SSH_PORT=10022",
  ]
  volume [
    gitlab_dir + "/data:/home/git/data",
    gitlab_dir + "/mysql:/var/lib/mysql",
  ]
end


#nginx
nginx_data_dir     = dockerfiles_Dir + "/" + nginx_service_name;

directory nginx_data_dir + "/data" do
  owner     "root"
  group     "docker"
  mode      "755"
  recursive true
  action    :create
end
template nginx_data_dir + "/data/nginx_default" do
  mode   "644"
  source "nginx_default.erb"
  variables ({
    :server_name => hostname,
  })
end
template nginx_data_dir + "/data/init.sh" do
  mode   "755"
  source "nginx_init.sh.erb"
end

simple_iptables_rule nginx_service_name + "_iptable" do
  rule [
    "--proto tcp --dport 80",
  ]
  jump "ACCEPT"
end

docker_container nginx_service_name do
  image          "dockerfile/nginx"
  detach         true
  container_name nginx_service_name
  command        "/data/init.sh"
  action         :run
  init_type      false
  port [
    "80:80",
  ]
  volume [
    nginx_data_dir + "/sites-enabled:/etc/nginx/sites-enabled",
    nginx_data_dir + "/log:/var/log/nginx",
    nginx_data_dir + "/data:/data",
  ]
  link [
    gitlab_service_name + ":" + gitlab_service_name,
  ]
end

