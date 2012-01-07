# Class: jenkins
#
# This is the main jenkins class
#
#
# == Parameters
#
# Standard class parameters - Define jenkins web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs jenkins using the OS common packages
#     - source  : Installs jenkins downloading the relevant war
#     - puppi   : Installs jenkins war via Puppi
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip.
#   Used if install => "source" or "puppi"
#   By default is the distro's default webapps directory
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check jenkins/manifests/params.pp before overriding the default settings
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check jenkins/manifests/params.pp before overriding the default settings
#
# [*url_check*]
#   An url of foo_webapp application to test the correct deployment of jenkins.
#   Used is monitor is enabled.
#
# [*url_pattern*]
#   A string that must exist in the defined url_check that confirms that the
#   application is running correctly
#
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, jenkins class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $jenkins_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, jenkins main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $jenkins_source
#
# [*source_dir*]
#   If defined, the whole jenkins configuration direrctory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $jenkins_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $jenkins_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, jenkins main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $jenkins_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $jenkins_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $jenkins_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $jenkins_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $jenkins_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $jenkins_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for jenkins checks
#   Can be defined also by the (top scope) variables $jenkins_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ip_address
#   Can be defined also by the (top scope) variables $jenkins_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $jenkins_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $jenkins_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $jenkins_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for jenkins port(s)
#   Can be defined also by the (top scope) variables $jenkins_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling jenkins. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $jenkins_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $jenkins_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $jenkins_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $jenkins_audit_only
#   and $audit_only
#
# Default class params - As defined in jenkins::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of jenkins package
#
# [*service*]
#   The name of jenkins service
#
# [*service_status*]
#   If the jenkins service init script supports status argument
#
# [*process*]
#   The name of jenkins process
#
# [*process_args*]
#   The name of jenkins arguments.
#   Used only in case the jenkins process name is generic (java, ruby...)
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $jenkins_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $jenkins_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include jenkins"
# - Call jenkins as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class jenkins (
  $install             = $jenkins::params::install,
  $install_source      = $jenkins::params::install_source,
  $install_destination = $jenkins::params::install_destination,
  $install_precommand  = $jenkins::params::install_precommand,
  $install_postcommand = $jenkins::params::install_postcommand,
  $url_check           = $jenkins::params::url_check,
  $url_pattern         = $jenkins::params::url_pattern,
  $my_class            = $jenkins::params::my_class,
  $source              = $jenkins::params::source,
  $source_dir          = $jenkins::params::source_dir,
  $source_dir_purge    = $jenkins::params::source_dir_purge,
  $template            = $jenkins::params::template,
  $options             = $jenkins::params::options,
  $absent              = $jenkins::params::absent,
  $disable             = $jenkins::params::disable,
  $disableboot         = $jenkins::params::disableboot,
  $monitor             = $jenkins::params::monitor,
  $monitor_tool        = $jenkins::params::monitor_tool,
  $monitor_target      = $jenkins::params::monitor_target,
  $puppi               = $jenkins::params::puppi,
  $puppi_helper        = $jenkins::params::puppi_helper,
  $firewall            = $jenkins::params::firewall,
  $firewall_tool       = $jenkins::params::firewall_tool,
  $firewall_src        = $jenkins::params::firewall_src,
  $firewall_dst        = $jenkins::params::firewall_dst,
  $debug               = $jenkins::params::debug,
  $audit_only          = $jenkins::params::audit_only,
  $package             = $jenkins::params::package,
  $service             = $jenkins::params::service,
  $service_status      = $jenkins::params::service_status,
  $process             = $jenkins::params::process,
  $process_args        = $jenkins::params::process_args,
  $config_dir          = $jenkins::params::config_dir,
  $config_file         = $jenkins::params::config_file,
  $config_file_mode    = $jenkins::params::config_file_mode,
  $config_file_owner   = $jenkins::params::config_file_owner,
  $config_file_group   = $jenkins::params::config_file_group,
  $config_file_init    = $jenkins::params::config_file_init,
  $pid_file            = $jenkins::params::pid_file,
  $data_dir            = $jenkins::params::data_dir,
  $log_dir             = $jenkins::params::log_dir,
  $log_file            = $jenkins::params::log_file,
  $port                = $jenkins::params::port,
  $protocol            = $jenkins::params::protocol
  ) inherits jenkins::params {

  validate_bool(  $source_dir_purge ,
                  $absent ,
                  $disable ,
                  $disableboot ,
                  $monitor ,
                  $puppi ,
                  $firewall ,
                  $debug ,
                  $audit_only )

  ### Definition of some variables used in the module
  $manage_package = $jenkins::absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $jenkins::disableboot ? {
    true    => false,
    default => $jenkins::disable ? {
      true    => false,
      default => $jenkins::absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $jenkins::disable ? {
    true    => 'stopped',
    default =>  $jenkins::absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  # We assume that is installed via package, jenkins has an indipendent service
  $manage_service_standalone = $jenkins::install ? {
    package => true,
    default => false,
  }

  $manage_file = $jenkins::absent ? {
    true    => 'absent',
    default => 'present',
  }

  # If $jenkins::disable == true we dont check jenkins on the local system
  if $jenkins::absent == true or $jenkins::disable == true or $jenkins::disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $jenkins::absent == true or $jenkins::disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $jenkins::audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $jenkins::audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $jenkins::source ? {
    ''        => undef,
    default   => $jenkins::source,
  }

  $manage_file_content = $jenkins::template ? {
    ''        => undef,
    default   => template($jenkins::template),
  }

  ### Managed resources
  # Installation is managed in dedicated class
  require jenkins::install

  if $jenkins::source or $jenkins::template or $jenkins::install == 'package' {
    file { 'jenkins.conf':
      ensure  => $jenkins::manage_file,
      path    => $jenkins::config_file,
      mode    => $jenkins::config_file_mode,
      owner   => $jenkins::config_file_owner,
      group   => $jenkins::config_file_group,
      require => Class['jenkins::install'],
      source  => $jenkins::manage_file_source,
      content => $jenkins::manage_file_content,
      replace => $jenkins::manage_file_replace,
      audit   => $jenkins::manage_audit,
    }
  }

  # The whole jenkins configuration directory can be recursively overriden
  if $jenkins::source_dir {
    file { 'jenkins.dir':
      ensure  => directory,
      path    => $jenkins::config_dir,
      require => Class['jenkins::install'],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $jenkins::manage_file_replace,
      audit   => $jenkins::manage_audit,
    }
  }

  # Service is managed only if jenkins package provides it
  if $jenkins::manage_service_standalone == true {
    service { 'jenkins':
      ensure     => $jenkins::manage_service_ensure,
      name       => $jenkins::service,
      enable     => $jenkins::manage_service_enable,
      hasstatus  => $jenkins::service_status,
      pattern    => $jenkins::process,
      require    => Package['jenkins'],
      subscribe  => File['jenkins.conf'],
    }
  }


  ### Include custom class if $my_class is set
  if $jenkins::my_class {
    include $jenkins::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $jenkins::puppi == true {
    $puppivars=get_class_args()
    file { 'puppi_jenkins':
      ensure  => $jenkins::manage_file,
      path    => "${settings::vardir}/puppi/jenkins",
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Class['puppi'],
      content => inline_template('<%= puppivars.to_yaml %>'),
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $jenkins::monitor == true and $jenkins::url_check != '' {
    monitor::url { 'jenkins_url':
      url     => $jenkins::url_check,
      pattern => $jenkins::url_pattern,
      port    => $jenkins::port,
      target  => $jenkins::monitor_target,
      tool    => $jenkins::monitor_tool,
      enable  => $jenkins::manage_monitor,
    }
  }

  ### Service monitoring, if enabled ( monitor => true ) and present
  if $jenkins::monitor == true and $jenkins::manage_service_standalone == true {
    monitor::port { "jenkins_${jenkins::protocol}_${jenkins::port}":
      protocol => $jenkins::protocol,
      port     => $jenkins::port,
      target   => $jenkins::params::monitor_target,
      tool     => $jenkins::monitor_tool,
      enable   => $jenkins::manage_monitor,
    }
    monitor::process { 'jenkins_process':
      process  => $jenkins::process,
      service  => $jenkins::service,
      pidfile  => $jenkins::pid_file,
      tool     => $jenkins::monitor_tool,
      enable   => $jenkins::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true ) and service present
  if $jenkins::firewall == true and $jenkins::manage_service_standalone == true {
    firewall { "jenkins_${jenkins::protocol}_${jenkins::port}":
      source      => $jenkins::firewall_source,
      destination => $jenkins::firewall_destination,
      protocol    => $jenkins::protocol,
      port        => $jenkins::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $jenkins::firewall_tool,
      enable      => $jenkins::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $jenkins::debug == true {
    file { 'debug_jenkins':
      ensure  => $jenkins::manage_file,
      path    => "${settings::vardir}/debug-jenkins",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
