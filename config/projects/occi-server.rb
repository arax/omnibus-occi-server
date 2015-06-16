name "occi-server"
maintainer "parak@cesnet.cz"
homepage "https://github.com/EGI-FCTF/rOCCI-server"

# Defaults to C:/occi-server on Windows
# and /opt/occi-server on all other platforms
install_dir "#{default_root}/#{name}"
build_version "1.1.6"
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
                  deps.concat ['mod_passenger >= 4.0', 'rubygem-passenger-devel >= 4.0']
                  deps
                else
                  # we are in Debian/Ubuntu
                  deps = %w(apache2 libapache2-modsecurity memcached git)
                  deps << 'libapache2-mod-passenger (>= 4.0)'
                  deps
                end
external_deps.each { |ext_dep| runtime_dependency ext_dep }

exclude "**/.git"
exclude "**/bundler/git"
