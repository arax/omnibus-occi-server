#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
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

name "rubygems"
default_version "2.4.1"

dependency "ruby"

version "2.4.1" do
  source :url => "http://production.cf.rubygems.org/rubygems/rubygems-2.4.1.tgz",
         :md5 => "7e39c31806bbf9268296d03bd97ce718"
end

relative_path "rubygems-#{version}"

build do
  ruby "setup.rb"
end
