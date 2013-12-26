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
  ssh_keys ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC668RDy9caaTDRzD+GK7CExHqoES0V8mO9c3HMVlae5rGpWQnSXMUkImnWRXlSM/ALyAOeA2NYqd64VPKp1nyka00IhdcH1EB/KT9vkVE8C4vcPHuaVRGCJNCEXj+9ATuvDKBRvsrmwOLYwMfcQc7JIOR15xTMkIO8E9aIfENwyLNFRJ22cjyi069b+Um7H+uoj+hkcMUdfSLT9iugigFmTrtWi4OsGwd+p0bZD1j9RV5mUlFdhtua+48ptVPqt7y+P8Sf4mZVj9zxSvrd6VB22/g6M/PXDXUIa5rP823fH/tUc3XqPg4Nb+bCXcVNKwmAAbpS1Ru7w7r4f3GnxYQJ kitsunai@kitsunai-VirtualBox",
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCklYsTPT4/J4a3hXEkrLkzLYwxC24sPuxI0A3idScXn6r5ZgwUwPLN5CQG6YVEIIKVrnRKIuubTB3o1XVDeOUwAegVGwiyfHw50Wx1WVyxBkdBA7JHqxJ7nsRgQfPUZmOQP5zZtXBNHXhTpaTM21j/FAwm215o6tIqo9aRxjw/3wsJzPUHhQzLR/DyOf82m6T5eY/3fYKUTNtycth8LjfNRq2TX32FHZrfyoVpcMNUIcapgofKIKcjMEEbo6Y09zV+S6rFywfcpFAzc0flRZ08Zi416i0JTRwg2vAje6ARbnZrpvIB/sOiQR7jFDMtcMaWFXrLeFeFxfinlTZnaE8D kitsunai@ckitsunai"]

end
