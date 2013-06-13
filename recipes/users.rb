#
# Cookbook Name:: s3cmd
# Recipe:: users
#
# Copyright 2013, Kwarter, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 's3cmd'

search("users", "groups:sysadmin NOT action:remove") do |u|
  if u['access_key']
    if u['home']
      home_dir = u['home']
    else
      home_dir = "/home/#{u['id']}"
    end
    template "#{home_dir}/.s3cfg" do
      source 's3cfg.erb'
      owner u['id']
      group u['id']
      mode 0600
      variables(
          :access_key    => u['access_key'],
          :access_secret => u['access_secret']
      )
    end
  end
end
