#
# Cookbook Name:: pxe-server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# dhcpd tftpd nfs
%w{isc-dhcp-server tftpd-hpa nfs-kernel-server}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#dhcp
template "/etc/dhcp/dhcpd.conf" do
  source "dhcpd.conf.erb"
  mode "644"
  owner "root"
  group "root"
end

#nfs
template "/etc/exports" do
  source "exports.erb"
  mode "644"
  owner "root"
  group "root"
end

#interfaces
template "/etc/network/interfaces" do
  source "interfaces.erb"
  mode "644"
  owner "root"
  group "root"
end

#mount
template "/etc/rc.local" do
  source "rc.local.erb"
  mode "755"
  owner "root"
  group "root"
end

#tftpd
template "/etc/default/tftpd-hpa" do
  source "tftpd-hpa.erb"
  mode "644"
  owner "root"
  group "root"
end

#tftp
directory "/var/lib/tftpboot/pxelinux.cfg" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

template "/var/lib/tftpboot/pxelinux.cfg/default" do
  source "default.erb"
  mode "644"
  owner "root"
  group "root"
end


package "syslinux" do
  action :upgrade
  notifies :run, 'bash[copy_pxelinux_0]', :immediately
end

bash 'copy_pxelinux_0'do
  user "root"
  action :nothing
  flags '-x'
  code <<-__EOL__
  cp /usr/lib/syslinux/pxelinux.0 /var/lib/tftpboot/pxelinux.0
  __EOL__
end

mount "/var/lib/tftpboot/image/ubuntu-13.10-desktop-amd64" do
  action :umount
  device "/var/lib/tftpboot/ubuntu-13.10-desktop-amd64.iso"
end

directory "/var/lib/tftpboot/image" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

directory "/var/lib/tftpboot/image/ubuntu-13.10-desktop-amd64" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

remote_file 'download_ubuntu_image' do
  source "http://releases.ubuntu.com/13.10/ubuntu-13.10-desktop-amd64.iso"
  path "/var/lib/tftpboot/ubuntu-13.10-desktop-amd64.iso"
  mode "644"
  owner "root"
  group "root"
  action :create_if_missing
end

package "grub-efi" do
  action :upgrade
  notifies :run, 'bash[make_netdir]', :immediately
end

bash 'make_netdir' do
  user "root"
  action :nothing
  flags '-x'
  code <<-__EOL__
  grub-mknetdir --net-directory=/var/lib/tftpboot
  __EOL__
end

template "/var/lib/tftpboot/boot/grub/grub.cfg" do
  source "grub.cfg.erb"
  mode "644"
  owner "root"
  group "root"
end

%w{isc-dhcp-server tftpd-hpa nfs-kernel-server}.each do |svc|
  service svc do
    supports :restart => true, :reload => true
    action [:enable, :reload]
  end
end

