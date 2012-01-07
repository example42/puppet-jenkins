# Class: jenkins::params
#
# This class defines default parameters used by the main module class jenkins
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to jenkins class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class jenkins::params {

  # Default installation type depends on OS package availability
  $install = 'package'

  # Install source from the upstream provider is updated to module's
  # last update time. You may need to change this:
  # use the "install_source" parameter of the jenkins class
  $install_source = 'http://mirrors.jenkins-ci.org/war/latest/jenkins.war'

  # By default we use Tomcat application server as installed by its package
  # if You want to use something else or different Tomcat instances
  # provide as an argument a different install_destination
  $tomcatpackageversion = $::operatingsystem ? {
    ubuntu                          => 'tomcat6',
    debian                          => $stdlib42::osver ? {
      5       => 'tomcat5.5',
      6       => 'tomcat6',
      default => 'tomcat6',
    },
    /(?i:CentOS|RedHat|Scientific)/ => $stdlib42::osver ? {
      5       => 'tomcat5',
      6       => 'tomcat6',
      default => 'tomcat6',
    },
    default                         => 'tomcat',
  }

  $install_destination = $::jenkins_install_destination ? {
    ''      => "/var/lib/$jenkins::params::tomcatpackageversion/webapps",
    default => $::jenkins_install_destination,
  }

  $install_precommand  = ''

  $install_postcommand = ''

  $url_check           = ''

  $url_pattern         = 'OK'


  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'jenkins',
  }

  $service = $::operatingsystem ? {
    default                   => 'jenkins',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'jenkins',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/jenkins',
  }

  $config_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/jenkins',
    default                   => '/etc/sysconfig/jenkins',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/jenkins',
    default                   => '/etc/sysconfig/jenkins',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/jenkins.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/jenkins',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/jenkins',
  }

  $log_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/syslog',
    default                   => '/var/log/messages',
  }

  $port = $::jenkins_port ? {
    ''      => '42',                    # Default value
    default => $::jenkins_port,
  }

  $protocol = $::jenkins_protocol ? {
    ''      => 'tcp',                   # Default value
    default => $::jenkins_protocol,
  }


  ### General variables that affect module's behaviour
  # They can be set at top scope level or in a ENC

  $my_class = $::jenkins_my_class ? {
    ''      => '',                      # Default value
    default => $::jenkins_my_class,
  }

  $source = $::jenkins_source ? {
    ''      => '',                      # Default value
    default => $::jenkins_source,
  }

  $source_dir = $::jenkins_source_dir ? {
    ''      => '',                      # Default value
    default => $::jenkins_source_dir,
  }

  $source_dir_purge = $::jenkins_source_dir_purge ? {
    ''      => false,                   # Default value
    default => $::jenkins_source_dir_purge,
  }

  $template = $::jenkins_template ? {
    ''      => '',                      # Default value
    default => $::jenkins_template,
  }

  $options = $::jenkins_options ? {
    ''      => '',                      # Default value
    default => $::jenkins_options,
  }

  $absent = $::jenkins_absent ? {
    ''      => false,                   # Default value
    default => $::jenkins_absent,
  }

  $disable = $::jenkins_disable ? {
    ''      => false,                   # Default value
    default => $::jenkins_disable,
  }

  $disableboot = $::jenkins_disableboot ? {
    ''      => false,                   # Default value
    default => $::jenkins_disableboot,
  }


  ### General module variables that can have a site or per module default
  # They can be set at top scope level or in a ENC

  $monitor = $::jenkins_monitor ? {
    ''      => $::monitor ? {
      ''      => false,                # Default value
      default => $::monitor,
    },
    default => $::jenkins_monitor,
  }

  $monitor_tool = $::jenkins_monitor_tool ? {
    ''      => $::monitor_tool ? {
      ''      => '',                   # Default value
      default => $::monitor_tool,
    },
    default => $::jenkins_monitor_tool,
  }

  $monitor_target = $::jenkins_monitor_target ? {
    ''      => $::monitor_target ? {
      ''      => $::ipaddress,         # Default value
      default => $::monitor_target,
    },
    default => $::jenkins_monitor_target,
  }

  $firewall = $::jenkins_firewall ? {
    ''      => $::firewall ? {
      ''      => false,                # Default value
      default => $::firewall,
    },
    default => $::jenkins_firewall,
  }

  $firewall_tool = $::jenkins_firewall_tool ? {
    ''      => $::firewall_tool ? {
      ''      => '',                   # Default value
      default => $::firewall_tool,
    },
    default => $::jenkins_firewall_tool,
  }

  $firewall_src = $::jenkins_firewall_src ? {
    ''      => $::firewall_src ? {
      ''      => '0.0.0.0/0',          # Default value
      default => $::firewall_src,
    },
    default => $::jenkins_firewall_src,
  }

  $firewall_dst = $::jenkins_firewall_dst ? {
    ''      => $::firewall_dst ? {
      ''      => $::ip_address,        # Default value
      default => $::firewall_dst,
    },
    default => $::jenkins_firewall_dst,
  }

  $puppi = $::jenkins_puppi ? {
    ''      => $::puppi ? {
      ''      => false,                # Default value
      default => $::puppi,
    },
    default => $::jenkins_puppi,
  }

  $puppi_helper = $::jenkins_puppi_helper ? {
    ''      => $::puppi_helper ? {
      ''      => 'standard',           # Default value
      default => $::puppi_helper,
    },
    default => $::jenkins_puppi_helper,
  }

  $debug = $::jenkins_debug ? {
    ''      => $::debug ? {
      ''      => false,                # Default value
      default => $::debug,
    },
    default => $::jenkins_debug,
  }

  $audit_only = $::jenkins_audit_only ? {
    ''      => $::audit_only ? {
      ''      => false,                # Default value
      default => $::audit_only,
    },
    default => $::jenkins_audit_only,
  }

}
