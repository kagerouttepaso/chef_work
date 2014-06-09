#
# Cookbook Name:: my_docker
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

docker_container 'samalba/docker-registry' do
  detach true
  port '5000:5000'
  env 'SETTINGS_FLAVOR=local'
#  volume '/mnt/docker:/docker-storage'
end
