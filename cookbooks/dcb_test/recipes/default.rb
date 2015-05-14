#
# Cookbook Name:: dcb_test
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# this is a disappointingly useless recipe
%w{testing testing2 testing3 testing4}.each do |pkg|
  package pkg do 
   action :nothing
  end
end
