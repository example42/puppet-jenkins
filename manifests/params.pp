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

  # Install source from the upstream provider is updated to module's
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

  $install_destination = "/var/lib/$jenkins::params::tomcatpackageversion/webapps"

  $install_precommand  = ''

  $install_postcommand = ''

  $url_check           = ''

  $url_pattern         = 'OK'


  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'jenkins',
  }

  $service = $::operatingsystem ? {
    default => 'jenkins',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => 'jenkins',
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

  $port = '8080'

  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
