require 'facter'

name "occi-server"
maintainer "Boris Parak <parak@cesnet.cz>"
homepage "https://github.com/EGI-FCTF/rOCCI-server"
description "An OCCI translation layer for a multitude of Cloud Management Frameworks and Public Cloud Service Providers."

# Defaults to C:/occi-server on Windows
# and /opt/occi-server on all other platforms
install_dir "#{default_root}/#{name}"
build_version "1.1.8"
build_iteration 1

override :rubygems, :version => '2.4.4'
override :ruby, :version => '2.1.5'

# Creates required build directories
dependency "preparation"

# occi-server dependencies/components
dependency "occi-server"

# Version manifest file
dependency "version-manifest"

# facter
dependency "facter"

# add external (runtime) dependencies/services
case Facter.value('operatingsystem')
when 'Debian', 'Ubuntu'
  # Ubuntu 12.04: 'deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main'
  # Ubuntu 14.04: 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main'
  # Debian 7: 'deb https://oss-binaries.phusionpassenger.com/apt/passenger wheezy main'
  # Debian 8: 'deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main'
  external_deps = %w(apache2 libapache2-modsecurity memcached git)
  external_deps.concat ['passenger (>= 4.0)', 'passenger-dev (>= 4.0)', 'libapache2-mod-passenger (>= 4.0)']
when 'CentOS'
  # Centos/Scientific Linux: https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
  external_deps = %w(httpd mod_ssl policycoreutils-python mod_security memcached git)
  external_deps.concat ['passenger >= 4.0', 'passenger-devel >= 4.0', 'mod_passenger >= 4.0']
end
external_deps.each { |ext_dep| runtime_dependency ext_dep }

# tweaking package-specific options
package :deb do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'Apache 2.0'
  priority 'extra'
  section 'net'
end

package :rpm do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'Apache 2.0'
  category 'Applications/System'
end

exclude "**/.git"
exclude "**/bundler/git"
