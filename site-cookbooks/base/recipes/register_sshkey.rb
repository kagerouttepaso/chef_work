#
# Cookbook Name:: base
# Recipe:: regist_sshkey
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute
#


#register sshkey
home_dir="/home/"+node[:current_user]
execute "register_sshkey" do
  user    node[:current_user]
  action  :run
  cwd     home_dir+"/.ssh/"
   command "cat id_rsa.pub  >> authorized_keys"
  environment(
    "HOME" => home_dir
  )
end
