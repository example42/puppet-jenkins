# jenkins::plugin based on https://github.com/rtyler/puppet-jenkins
#
# Plugin installation is only possible with $jenkins::install = package
# due to the dependency on Service['jenkins'].
#
# TODO: Investigate usage of jenkins-cli to mitigate this limitation.
#
define jenkins::plugin (
  $version = '',
  $enabled = true,

) {

  include jenkins::params

  $ensure = bool2ensure($enabled)

  if (!defined(Service['jenkins'])) {
    fail('Plugin installation not possible without a running jenkins installed by package.')
  }

  $plugin_dir = "${jenkins::data_dir}/plugins"

  if $version {
    $base_url = "http://updates.jenkins-ci.org/download/plugins/${name}/${version}/"
  }
  else {
    $base_url = 'http://updates.jenkins-ci.org/latest/'
  }

  if (!defined(File[$plugin_dir])) {
    file { [ $plugin_dir ]:
      ensure  => directory,
      owner   => $jenkins::config_file_owner,
      group   => $jenkins::config_file_group,
      mode    => $jenkins::config_file_mode,
      require => User['jenkins'],
    }
  }

  if (!defined(User[$jenkins::config_file_owner])) {
    user { $jenkins::config_file_owner:
      ensure => present,
    }
  }

  # Allow plugins that are already installed to be enabled/disabled.
  if $enabled == false {
    file { [ "${plugin_dir}/${name}.hpi.disabled", "${plugin_dir}/${name}.jpi.disabled" ]:
      ensure  => present,
      owner   => $jenkins::config_file_owner,
      mode    => $jenkins::config_file_mode,
      require => File[$plugin_dir],
      notify  => Service[$jenkins::service],
    }
  }

  exec { "download-jenkins-${name}" :
    command => "rm -f ${name}.hpi.disabled ${name}.jpi.disabled ; wget --no-check-certificate ${base_url}${name}.hpi",
    cwd     => $plugin_dir,
    require => [ File[$plugin_dir], Package['wget'] ],
    path    => [ '/usr/bin', '/usr/sbin', '/bin' ],
    user    => $jenkins::config_file_owner,
    unless  => "test -f ${plugin_dir}/${name}.hpi || test -f ${plugin_dir}/${name}.jpi",
    notify  => Service[$jenkins::service],
  }
}
