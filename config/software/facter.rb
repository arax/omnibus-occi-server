name "facter"

dependency "ruby"
dependency "rubygems"

build do
  gem "install facter -n #{install_dir}/bin --no-rdoc --no-ri"
end
