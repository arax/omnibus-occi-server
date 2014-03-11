name "occi-server"
default_version "1.0.0.beta.2"

dependency "ruby"
dependency "rubygems"

build do
  command "git clone https://github.com/EGI-FCTF/rOCCI-server /opt/occi-server"
  command "cd /opt/occi-server && git checkout master"
  gem "install bundler -n #{install_dir}/bin --no-rdoc --no-ri"
  command "cd /opt/occi-server && bundle install --deployment"
end

