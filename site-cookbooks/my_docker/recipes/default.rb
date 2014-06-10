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
  group  "root"
  mode   "755"
  action :create
end

#gitlab
%w{data mysql}.each do |dir|
  directory dockerfiles_Dir + "/" + dir do
    owner  "docker"
    group  "root"
    mode   "755"
    action :create
  end
end
docker_container "gitlab" do
  image "sameersbn/gitlab:6.9.2"
  detach   true
  container_name "gitlab"
  port     "10022:22"
  env [
    "NGINX_MAX_UPLOAD_SIZE=512m",
    "GITLAB_HOST=" + hostname,
    "GITLAB_SUPPORT=" + support_Mail_Address,
    "GITLAB_BACKUPS=daily",
    "GITLAB_RELATIVE_URL_ROOT=/gitlab",
    "GITLAB_SSH_PORT=10022",
  ]
  volume [
    dockerfiles_Dir + "/data:/home/git/data",
    dockerfiles_Dir + "/mysql:/var/lib/mysql",
  ]
  action :run
end

