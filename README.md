# rOCCI-server Omnibus project

This project creates full-stack platform-specific packages for [rOCCI-server](https://github.com/EGI-FCTF/rOCCI-server).

## Installation

We'll assume you have Ruby 1.9+ and Bundler installed. First ensure all
required gems are installed and ready to use:

```shell
$ bundle install --binstubs
```

## Usage

### Build

You create a platform-specific package using the `build project` command:

```shell
$ omnibus build project occi-server
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. So running this command on say a
MacBook Pro will generate a Mac OS X specific package. After the build
completes packages will be available in `pkg/`.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ omnibus clean occi-server
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/occi-server`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ omnibus clean occi-server --purge
```

### BuildLab

* [VirtualBox 4.3+](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant 1.4+](http://www.vagrantup.com/downloads.html)

```shell
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
```

To build packages for all platforms:
```shell
vagrant up
```

To build package for a specific platform:
```shell
vagrant up PLATFORM
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ omnibus help
```

