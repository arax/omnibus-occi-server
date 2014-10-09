project_name = 'occi-server'
work_dir = "/home/vagrant/#{project_name}"

bash 'run_omnibus_build' do
  case node[:platform]
  when 'debian'
    case node[:platform_version]
    when '7.6'
      pkg_dir = 'debian-7'
    when '6.0.10'
      pkg_dir = 'debian-6'
    end
  when 'centos'
    case node[:platform_version]
    when '5.10'
      pkg_dir = 'centos-5'
    when '6.5'
      pkg_dir = 'centos-6'
    end
  when 'ubuntu'
    case node[:platform_version]
    when '10.04'
      pkg_dir = 'ubuntu-10.04'
    when '12.04'
      pkg_dir = 'ubuntu-12.04'
    when '14.04'
      pkg_dir = 'ubuntu-14.04'
    end
  end

  user 'vagrant'
  group 'omnibus'

  pkg_dir = pkg_dir ? "#{work_dir}/packages/#{pkg_dir}" : "#{work_dir}/packages"
  cwd work_dir
  timeout 7200

  code <<-EOC
    bundle install --binstubs
    bin/omnibus build #{project_name}
    mkdir -p #{pkg_dir}
    cp #{work_dir}/pkg/* #{pkg_dir}
    rm -r #{work_dir}/pkg
  EOC
end
