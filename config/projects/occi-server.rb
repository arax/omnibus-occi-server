name "occi-server"
maintainer "parak@cesnet.cz"
homepage "https://github.com/EGI-FCTF/rOCCI-server"

replaces        "occi-server"
install_path    "/opt/occi-server"
build_version   "1.1.0.beta.2"
build_iteration 1

# creates required build directories
dependency "preparation"

# version manifest file
dependency "version-manifest"

# occi-server dependencies/components
dependency "occi-server"

# add external (runtime) dependencies/services
external_deps = if File.exists?('/etc/redhat-release')
                  # we are on CentOS/SL
                  %w(gcc-c++ curl-devel httpd httpd-devel apr-devel apr-util-devel mod_ssl policycoreutils-python mod_security memcached openssl-devel zlib-devel git)
                else
                  # we are in Debian/Ubuntu
                  %w(apache2 libapache2-mod-passenger libapache2-modsecurity memcached git)
                end
external_deps.each { |ext_dep| runtime_dependency ext_dep }

exclude "\.git*"
exclude "bundler\/git"
