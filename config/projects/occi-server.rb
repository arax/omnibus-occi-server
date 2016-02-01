name "occi-server"
maintainer "Boris Parak <parak@cesnet.cz>"
homepage "https://github.com/EGI-FCTF/rOCCI-server"
description "An OCCI translation layer for a multitude of Cloud Management Frameworks and Public Cloud Service Providers."

# Defaults to C:/occi-server on Windows
# and /opt/occi-server on all other platforms
install_dir "#{default_root}/#{name}"
build_version "1.1.7"
build_iteration 1

override :rubygems, :version => '2.4.4'
override :ruby, :version => '2.1.5'

# Creates required build directories
dependency "preparation"

# occi-server dependencies/components
dependency "occi-server"

# Version manifest file
dependency "version-manifest"

# add external (runtime) dependencies/services
external_deps = if File.exists?('/etc/redhat-release')
                  # we are on CentOS/SL
                  deps = %w(httpd mod_ssl policycoreutils-python mod_security memcached git)
                  deps.concat ['mod_passenger >= 5.0', 'passenger-devel >= 5.0']
                  deps
                else
                  # we are in Debian/Ubuntu
                  deps = %w(apache2 libapache2-modsecurity memcached git)
                  deps << 'libapache2-mod-passenger (>= 5.0)'
                  deps
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
