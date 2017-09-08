name 'occi-server'
default_version 'master'

license "Apache-2.0"
license_file "LICENSE"

dependency 'ruby'
dependency 'rubygems'
dependency 'liblzma'

env = {
  'LDFLAGS' => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  'CFLAGS' => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  'LD_RUN_PATH' => "#{install_dir}/embedded/lib",
}

source git: 'https://github.com/the-rocci-project/rOCCI-server.git'

build do
  gem "install bundler -n #{install_dir}/embedded/bin --no-rdoc --no-ri"
  bundle "install --deployment --without development test --path=#{install_dir}/embedded/app/vendor/bundle", :env => env
  sync project_dir, "#{install_dir}/embedded/app/rOCCI-server", exclude: %w[.git .gitignore]
  copy File.join(project.files_path, '*'), "#{install_dir}/bin/"
  delete "#{install_dir}/embedded/app/rOCCI-server/vendor/bundle"
  delete "#{install_dir}/embedded/app/vendor/bundle/ruby/*/cache/*"
end
