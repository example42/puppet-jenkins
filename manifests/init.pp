# = Class: jenkins
#
# This is the main jenkins class
#
#
# == Parameters
#
# Class specific parameters - Define jenkins web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs jenkins using the OS common packages
#     - source  : Installs jenkins downloading the relevant war
#     - puppi   : Installs jenkins war via Puppi
#
# [*install_source*]
#   The URL from where to retrieve the source war.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#
# [*install_destination*]
#   The base path where to extract the source war.
#   Used if install => "source" or "puppi"
#   By default is the distro's default webapps directory
#
# [*install_precommand*]
#   A custom command to execute before installing the source war.
#   Used if install => "source" or "puppi"
#   Check jenkins/manifests/params.pp before overriding the default settings
#
# [*install_postcommand*]
#   A custom command to execute after installing the source war.
#   Used if install => "source" or "puppi"
#   Check jenkins/manifests/params.pp before overriding the default settings
#
# [*url_check*]
#   An url to test the correct deployment of jenkins.
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
#   If defined, the whole jenkins configuration directory content is retrieved
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
# [*service_autorestart*]
#   Automatically restarts the foo service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
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
# [*process_user*]
#   The name of the user foo runs with. Used by puppi and monitor.
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
  $install             = params_lookup( 'install' ),
  $install_source      = params_lookup( 'install_source' ),
  $install_destination = params_lookup( 'install_destination' ),
  $install_precommand  = params_lookup( 'install_precommand' ),
  $install_postcommand = params_lookup( 'install_postcommand' ),
  $url_check           = params_lookup( 'url_check' ),
  $url_pattern         = params_lookup( 'url_pattern' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits jenkins::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $jenkins::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $jenkins::bool_disableboot ? {
    true    => false,
    default => $jenkins::bool_disable ? {
      true    => false,
      default => $jenkins::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $jenkins::bool_disable ? {
    true    => 'stopped',
    default =>  $jenkins::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $jenkins::bool_service_autorestart ? {
    true    => Service[jenkins],
    false   => undef,
  }

  # We assume that is installed via package, jenkins has an indipendent service
  $manage_service_standalone = $jenkins::install ? {
    package => true,
    default => false,
  }

  $manage_file = $jenkins::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $jenkins::bool_absent == true
  or $jenkins::bool_disable == true
  or $jenkins::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $jenkins::bool_absent == true
  or $jenkins::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $jenkins::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $jenkins::bool_audit_only ? {
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

  if $jenkins::source
  or $jenkins::template
  or $jenkins::install == 'package' {
    file { 'jenkins.conf':
      ensure  => $jenkins::manage_file,
      path    => $jenkins::config_file,
      mode    => $jenkins::config_file_mode,
      owner   => $jenkins::config_file_owner,
      group   => $jenkins::config_file_group,
      require => Class['jenkins::install'],
      notify  => $jenkins::manage_service_autorestart,
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
      notify  => $jenkins::manage_service_autorestart,
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
  if $jenkins::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'jenkins':
      ensure    => $jenkins::manage_file,
      variables => $classvars,
      helper    => $jenkins::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $jenkins::bool_monitor == true
  and $jenkins::url_check != '' {
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
  if $jenkins::bool_monitor == true
  and $jenkins::manage_service_standalone == true {
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
      user     => $jenkins::process_user,
      tool     => $jenkins::monitor_tool,
      enable   => $jenkins::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true ) and service present
  if $jenkins::bool_firewall == true
  and $jenkins::manage_service_standalone == true {
    firewall { "jenkins_${jenkins::protocol}_${jenkins::port}":
      source      => $jenkins::firewall_src,
      destination => $jenkins::firewall_dst,
      protocol    => $jenkins::protocol,
      port        => $jenkins::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $jenkins::firewall_tool,
      enable      => $jenkins::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $jenkins::bool_debug == true {
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
