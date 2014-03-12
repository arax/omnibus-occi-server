name "occi-server"
default_version "1.0.0.beta.2"

dependency "ruby"
dependency "rubygems"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "git clone https://github.com/EGI-FCTF/rOCCI-server #{install_dir}/embedded/app"
  command "cd #{install_dir}/embedded/app && git checkout master"
  gem "install bundler -n #{install_dir}/bin --no-rdoc --no-ri"
  gem "install rake -n #{install_dir}/bin --no-rdoc --no-ri"
  bundle "install --deployment --without development test --path=#{install_dir}/embedded/app/vendor/bundle", :env => env
end

