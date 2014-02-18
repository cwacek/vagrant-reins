# Vagrant::Reins

A wrapper around the vagrant command line tools, making use of
the machine readable output added in 1.4.x to control Vagrant.

This is version 0.0.1, barely working, but you can currently
start Vagrant VMs using reins


## Usage

    require 'vagrant/reins/harness'

    harness = Vagrant::Reins::Harness.new 'path_to/vagrant_project_dir'
    harness.status

    harness.up

## Contributing

1. Fork it ( http://github.com/cwacek/vagrant-reins/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
