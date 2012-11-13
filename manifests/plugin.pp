# jenkins::plugin based on https://github.com/rtyler/puppet-jenkins
#
# Plugin installation is only possible with $jenkins::install = package
# due to the dependency on Service['jenkins'].
#
# TODO: Investigate usage of jenkins-cli to mitigate this limitation.
define jenkins::plugin ($version='') {

  include jenkins::params

  if (!defined(Service['jenkins'])) {
    fail('Plugin installation not possible without a running jenkins installed by package.')
  }

  $plugin_parent_dir = '/var/lib/jenkins'
  $plugin_dir        = '/var/lib/jenkins/plugins'

  if $version {
    $base_url = "http://updates.jenkins-ci.org/download/plugins/${name}/${version}/"
  }
  else {
    $base_url = 'http://updates.jenkins-ci.org/latest/'
  }

  if (!defined(File[$plugin_dir])) {
    file { [ $plugin_parent_dir, $plugin_dir ]:
      ensure  => directory,
      owner   => 'jenkins',
      mode    => '0644',
      require => User['jenkins'],
    }

    File[$plugin_parent_dir] {
      group => 'adm',
    }

    File[$plugin_dir] {
      group => 'nogroup',
    }
  }

  if (!defined(User['jenkins'])) {
    user { 'jenkins':
      ensure => present,
    }
  }

  exec { "download-jenkins-${name}" :
    command => "wget --no-check-certificate ${base_url}${name}.hpi",
    cwd     => $plugin_dir,
    require => File[$plugin_dir],
    path    => [ '/usr/bin', '/usr/sbin' ],
    user    => 'jenkins',
    unless  => "test -f ${plugin_dir}/${name}.hpi || test -f ${plugin_dir}/${name}.jpi",
    notify  => Service['jenkins'],
  }
}
