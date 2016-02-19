#
# Cookbook Name:: my_users
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
users_manage "sysadmin" do
   action [ :remove, :create ]
end

users_manage "dev" do
   action [ :remove, :create ]
end

group 'sysadmin' do
  append                     false
  gid                        505
  group_name                 "sysadmin"
  members                    ["han","vader"]
  system                     true 
  action                     :create 
end

group 'dev' do
  append                     false
  gid                        506
  group_name                 "dev"
  members                    ["chewbacca"]
  system                     true
  action                     :create
end


node.default['authorization']['sudo']['passwordless'] = true
include_recipe "sudo"
include_recipe "users"
