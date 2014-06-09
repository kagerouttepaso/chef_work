#
# Cookbook Name:: my_docker
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

docker_container 'mongo' do
  detach true
  hostname "same-mongo"
  #env 'SETTINGS_FLAVOR=local'
  #port '5000:5000'
  #volume '/mnt/docker:/docker-storage'
  #action :run
  action :remove
end
