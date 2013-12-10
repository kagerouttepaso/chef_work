#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "tmux" do
  action :install
end

package "zsh" do
  action :install
end

package "vim-nox" do
  action :install
end

package "exuberant-ctags" do
  action :install
end

package "tree" do
  action :install
end

package "ruby2.0" do
  action :install
end

package "ruby2.0-dev" do
  action :install
end

package "git" do
  action :install
end

package "git-svn" do
  action :install
end

package "subversion" do
  action :install
end

package "xubuntu-desktop" do
  action :install
end
