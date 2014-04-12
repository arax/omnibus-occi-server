name "occi-server"
maintainer "parak@cesnet.cz"
homepage "https://github.com/EGI-FCTF/rOCCI-server"

replaces        "occi-server"
install_path    "/opt/occi-server"
build_version   "1.0.0.beta.9"
build_iteration 2

# creates required build directories
dependency "preparation"

# version manifest file
dependency "version-manifest"

# occi-server dependencies/components
dependency "occi-server"

exclude "\.git*"
exclude "bundler\/git"
