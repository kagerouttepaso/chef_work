#
# Cookbook Name:: serverbase
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

gem_package "ruby-shadow" do
  action :upgrade
end

user_account "kitsunai" do
  action :create
  password "$6$kitsunai$kzKmt9.wC7b4kqG1SDBqJil8hxpd5RyjaXnWwvZ95QVOqDpXjyrbv.DOBPRijN835kagsQXLOxTsLrtnEJIii."
  ssh_keys ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC668RDy9caaTDRzD+GK7CExHqoES0V8mO9c3HMVlae5rGpWQnSXMUkImnWRXlSM/ALyAOeA2NYqd64VPKp1nyka00IhdcH1EB/KT9vkVE8C4vcPHuaVRGCJNCEXj+9ATuvDKBRvsrmwOLYwMfcQc7JIOR15xTMkIO8E9aIfENwyLNFRJ22cjyi069b+Um7H+uoj+hkcMUdfSLT9iugigFmTrtWi4OsGwd+p0bZD1j9RV5mUlFdhtua+48ptVPqt7y+P8Sf4mZVj9zxSvrd6VB22/g6M/PXDXUIa5rP823fH/tUc3XqPg4Nb+bCXcVNKwmAAbpS1Ru7w7r4f3GnxYQJ kitsunai@kitsunai-VirtualBox" ]
end
