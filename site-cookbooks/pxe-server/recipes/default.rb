#
# Cookbook Name:: pxe-server
# Recipe:: default
#
# Copyright 2014, kitsunai
#
# License : MIT
#

#### 仮想マシン設定
#ネットワークアダプター2の設定
template "/etc/network/interfaces" do
  source "interfaces.erb"
  mode "644"
  owner "root"
  group "root"
end
#### 仮想マシン設定 end

#### 各種サービス設定
# dhcpd,tftpd,nfsのインストール
%w{isc-dhcp-server tftpd-hpa nfs-kernel-server}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#dhcpdの設定ファイル
template "/etc/dhcp/dhcpd.conf" do
  source "dhcpd.conf.erb"
  mode "644"
  owner "root"
  group "root"
end

#nfsの設定ファイル
template "/etc/exports" do
  source "exports.erb"
  mode "644"
  owner "root"
  group "root"
end

#tftpdの設定ファイル
template "/etc/default/tftpd-hpa" do
  source "tftpd-hpa.erb"
  mode "644"
  owner "root"
  group "root"
end

#### 各種サービス設定 end

#### tftpdルートフォルダの構築
# LegacyBoot用のBoot設定ファイルの配置
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

# LegacyBoot用のブートローダー配置
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

# Ubuntu Image
# Ubuntu Image アンマウント
mount "/var/lib/tftpboot/image/ubuntu-13.10-desktop-amd64" do
  action :umount
  device "/var/lib/tftpboot/ubuntu-13.10-desktop-amd64.iso"
end
# マウント用のフォルダ作成
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
# Ubuntu Image ダウンロード
remote_file 'download_ubuntu_image' do
  source "http://releases.ubuntu.com/13.10/ubuntu-13.10-desktop-amd64.iso"
  path "/var/lib/tftpboot/ubuntu-13.10-desktop-amd64.iso"
  mode "644"
  owner "root"
  group "root"
  action :create_if_missing
end
#Ubuntu Imageのマウント設定
template "/etc/rc.local" do
  source "rc.local.erb"
  mode "755"
  owner "root"
  group "root"
end

#UEFI Boot用ブートローダー構築用パッケージ
package "grub-efi" do
  action :upgrade
  notifies :run, 'bash[make_netdir]', :immediately
end
#UEFI Boot用ブートローダー構築
bash 'make_netdir' do
  user "root"
  action :nothing
  flags '-x'
  code <<-__EOL__
  grub-mknetdir --net-directory=/var/lib/tftpboot
  __EOL__
end
#UEFI Boot用ブートローダーの設定ファイル配置
template "/var/lib/tftpboot/boot/grub/grub.cfg" do
  source "grub.cfg.erb"
  mode "644"
  owner "root"
  group "root"
end
#### tftpdルートフォルダの構築 end

#サービス登録
%w{isc-dhcp-server tftpd-hpa nfs-kernel-server}.each do |svc|
  service svc do
    supports :restart => true, :reload => true
    action [:enable, :reload]
  end
end

