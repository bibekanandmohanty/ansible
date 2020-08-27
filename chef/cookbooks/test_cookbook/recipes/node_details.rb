#
# Cookbook:: test_cookbook
# Recipe:: node_details
#
# Copyright:: 2020, The Authors, All Rights Reserved.

file 'basic_info' do
content "This is to get Attributes
HOSTNAME: #{node['hostname']}
IPADDRESS: #{node['ipaddress']}
CPU: #{node['cpu']['0']['mhz']}
MEMORY: #{node['memory']['total']}"
owner 'root'
group 'root'
action :create
end
