#
# Cookbook Name:: serverbase
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#to enabele password of user_account
gem_package "ruby-shadow" do
  action :upgrade
end

#create user
user_account "kitsunai" do
  action :create
  password "$6$kitsunai$kzKmt9.wC7b4kqG1SDBqJil8hxpd5RyjaXnWwvZ95QVOqDpXjyrbv.DOBPRijN835kagsQXLOxTsLrtnEJIii."
  ssh_keys [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCklYsTPT4/J4a3hXEkrLkzLYwxC24sPuxI0A3idScXn6r5ZgwUwPLN5CQG6YVEIIKVrnRKIuubTB3o1XVDeOUwAegVGwiyfHw50Wx1WVyxBkdBA7JHqxJ7nsRgQfPUZmOQP5zZtXBNHXhTpaTM21j/FAwm215o6tIqo9aRxjw/3wsJzPUHhQzLR/DyOf82m6T5eY/3fYKUTNtycth8LjfNRq2TX32FHZrfyoVpcMNUIcapgofKIKcjMEEbo6Y09zV+S6rFywfcpFAzc0flRZ08Zi416i0JTRwg2vAje6ARbnZrpvIB/sOiQR7jFDMtcMaWFXrLeFeFxfinlTZnaE8D kitsunai@ckitsunai"]
  comment "Kitsunai Daisuke"
end

##iptable
## Exampleをコピりました
## Reject packets other than those explicitly allowed
simple_iptables_policy "INPUT" do
  policy "DROP"
end

# The following rules define a "system" chain; chains
# are used as a convenient way of grouping rules together,
# for logical organization.

# Allow all traffic on the loopback device
simple_iptables_rule "system" do
  rule "--in-interface lo"
  jump "ACCEPT"
end

# Allow any established connections to continue,  even
# if they would be in violation of other rules.
simple_iptables_rule "system" do
  rule "-m conntrack --ctstate ESTABLISHED,RELATED"
  jump "ACCEPT"
end

# Allow SSH
simple_iptables_rule "ssh" do
  rule "--proto tcp --dport 22"
  jump "ACCEPT"
end

# Allow HTTP,  HTTPS
simple_iptables_rule "http" do
  rule [ "--proto tcp --dport 80",
         "--proto tcp --dport 443" ]
  jump "ACCEPT"
end
