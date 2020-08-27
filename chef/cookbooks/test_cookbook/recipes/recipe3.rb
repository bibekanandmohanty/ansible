#
# Cookbook:: test_cookbook
# Recipe:: recipe3
#
# Copyright:: 2020, The Authors, All Rights Reserved.
package "httpd" do
action :install
end

file '/var/www/html/index.html' do
content 'Hello this is bibek'
action :create
end

service 'httpd' do
action [:enable , :start]
end
