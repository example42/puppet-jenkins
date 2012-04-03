# jenkins::plugin based on https://github.com/rtyler/puppet-jenkins
# To test and adapt
define jenkins::plugin ( $version ='') {

  include jenkins::params

  $plugin            = "${name}.hpi"
  $plugin_parent_dir = '/var/lib/jenkins'
  $plugin_dir        = '/var/lib/jenkins/plugins'

  if $version {
    $base_url = "http://updates.jenkins-ci.org/download/plugins/${name}/${version}/"
  }
  else {
    $base_url = 'http://updates.jenkins-ci.org/latest/'
  }

  exec { "download-jenkins-${name}" :
      command  => "wget --no-check-certificate ${base_url}${plugin}",
      cwd      => $plugin_dir,
      require  => File[$plugin_dir],
      path     => [ '/usr/bin', '/usr/sbin' ],
      user     => 'jenkins',
      unless   => "test -f ${plugin_dir}/${plugin}";
  }
}
