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

name "gdbm_old"
default_version "1.8.3"

dependency "libgcc"

version "1.8.3" do
  source :url => 'https://github.com/arax/omnibus-occi-cli/raw/master/files/gdbm-1.8.3.tar.gz',
         :md5 => '69be333553e31f3e23b4d05c9795599e'
end

relative_path "gdbm-#{version}"

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]

  if platform == "freebsd"
    configure_command << "--with-pic"
  end

  command configure_command.join(" ")
  command "make -j #{max_build_jobs}"
  command "make install"
  command "make install-compat"
end
