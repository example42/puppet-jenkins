# Puppet module: jenkins

This is a Puppet jenkins module from the second generation of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42 - http://www.example42.com

Released under the terms of Apache 2 License.

Check Modulefile for dependencies.

## GENERAL USAGE
This module can be used in 2 ways:

* With the old style "Set variables and include class" pattern:

        $jenkins_template = "example42/jenkins/jenkins.conf.erb"
        include jenkins

* As a parametrized class:

        class { "jenkins":
          template => "example42/jenkins/jenkins.conf.erb",
        }

You can even, under some degrees, mix these two patterns.

You can for example set general top scope variables that affect all your parametrized classes:

        $puppi = true
        $monitor = true
        $monitor_tool = [ "nagios" , "munin" , "puppi" ]
        class { "jenkins":
          template => "example42/jenkins/jenkins.conf.erb",
        }
        
The above example has the same effect of:

        class { "jenkins":
          template => "example42/jenkins/jenkins.conf.erb",
          puppi        => true,
          monitor      => true,
          monitor_tool => [ "nagios" , "munin" , "puppi" ],
        }

Note that if you use the "Set variables and include class" pattern you can define variables only
at the top level scope or in a ENC (External Node Classifer) like Puppet Dashboard, Puppet Enterprise Console or The Foreman.

Below you have an overview of the most important module's parameters (you can mix and aggregate them).

The examples use parametrized classes, but for all the parameters you can set a $jenkins_ top scope variable.

For example, the variable "$jenkins_absent" is equivant to the "absent =>" parameter.

## USAGE - Basic management
* Install jenkins with default settings

        class { "jenkins": }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check jenkins/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "jenkins":
          install             => "source",
          install_source      => "http://deploy.example42.com/jenkins.war",
          install_destination => "/opt/apps/",
          # install_precommand  => "...",
          # install_postcommand => "...",
          # url_check           => "...",
          # url_pattern         => "...",
        }

* Disable jenkins service.

        class { "jenkins":
          disable => true
        }

* Disable jenkins service at boot time, but don't stop if is running.

        class { "jenkins":
          disableboot => true
        }

* Remove jenkins package

        class { "jenkins":
          absent => true
        }

* Enable auditing without without making changes on existing jenkins configuration files

        class { "jenkins":
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "jenkins":
          source => [ "puppet:///modules/lab42/jenkins/jenkins.conf-${hostname}" , "puppet:///modules/lab42/jenkins/jenkins.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { "jenkins":
          source_dir       => "puppet:///modules/lab42/jenkins/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file 

        class { "jenkins":
          template => "example42/jenkins/jenkins.conf.erb",      
        }

* Define custom options that can be used in a custom template without the
  need to add parameters to the jenkins class

        class { "jenkins":
          template => "example42/jenkins/jenkins.conf.erb",    
          options  => {
            'LogLevel' => 'INFO',
            'UsePAM'   => 'yes',
          },
        }

* Automaticallly include a custom subclass

        class { "jenkins:"
          my_class => 'jenkins::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "jenkins": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "jenkins":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "jenkins":
          monitor      => true,
          monitor_tool => [ "nagios" , "monit" , "munin" ],
        }

* Activate automatic firewalling 
  This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { "jenkins":       
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }


