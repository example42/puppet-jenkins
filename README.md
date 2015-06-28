# Puppet module: jenkins

## DEPRECATION NOTICE
This module is no more actively maintained and will hardly be updated.

Please find an alternative module from other authors or consider [Tiny Puppet](https://github.com/example42/puppet-tp) as replacement.

If you want to maintain this module, contact [Alessandro Franceschi](https://github.com/alvagante)


This is a Puppet module for jenkins based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-jenkins

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install jenkins with default settings

        class { 'jenkins': }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check jenkins/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "jenkins":
          install             => 'source',
          install_source      => 'http://deploy.example42.com/jenkins.war',
          install_destination => '/opt/apps/',
        }

* Disable jenkins service.

        class { 'jenkins':
          disable => true
        }

* Remove jenkins package

        class { 'jenkins':
          absent => true
        }

* Enable auditing without making changes on existing jenkins configuration files

        class { 'jenkins':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'jenkins':
          source => [ "puppet:///modules/lab42/jenkins/jenkins.conf-${hostname}" , "puppet:///modules/lab42/jenkins/jenkins.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'jenkins':
          source_dir       => 'puppet:///modules/lab42/jenkins/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'jenkins':
          template => 'example42/jenkins/jenkins.conf.erb',
        }

* Automatically include a custom subclass

        class { 'jenkins':
          my_class => 'jenkins::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'jenkins':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'jenkins':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'jenkins':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'jenkins':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


[![Build Status](https://travis-ci.org/example42/puppet-jenkins.png?branch=master)](https://travis-ci.org/example42/puppet-jenkins)
