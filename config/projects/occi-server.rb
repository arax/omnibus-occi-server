name 'occi-server'
maintainer 'Boris Parak <parak@cesnet.cz>'
homepage 'https://github.com/the-rocci-project/rOCCI-server'
description 'The rOCCI Framework - Server-side implementation for OpenNebula'

# Defaults to C:/occi-server on Windows
# and /opt/occi-server on all other platforms
install_dir "#{default_root}/#{name}"
build_version '2.0.2'
build_iteration 1

override :rubygems, :version => '2.6.8'
override :ruby, :version => '2.4.2'

# Creates required build directories
dependency 'preparation'

# occi-server dependencies/components
dependency 'occi-server'

# Version manifest file
dependency 'version-manifest'

# add external (runtime) dependencies/services
runtime_dependency 'memcached'

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

exclude '**/.git'
exclude '**/bundler/git'
