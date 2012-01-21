# Class: jenkins::repository
#
# This class installs jenkins repositories.
# Required for installation based on package
#
# == Variables
#
# Refer to jenkins class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by jenkins main class.
# This class uses default file and exec defines to avoid more
# Example42 dependencies (sigh)
#
class jenkins::repository inherits jenkins {

  case $::operatingsystem {

    ubuntu , debian: {
      file { 'jenkins.list':
        ensure  => present,
        path    => '/etc/apt/sources.list.d/jenkins.list',
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        content => 'deb http://pkg.jenkins-ci.org/debian binary/',
        before  => Exec['aptkey_add_jenkins'],
      }
      exec { 'aptkey_add_jenkins':
        command => 'wget -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -',
        unless  => 'apt-key list | grep -q D50582E6',
        path    => '/bin:/usr/bin',
      }
      exec { 'aptget_update_jenkins':
        command   => 'apt-get update',
        subscribe => File['jenkins.list'],
        path      => '/bin:/usr/bin',
      }

    }

    centos , redhat , scientific: {
      yumrepo { 'jenkins':
        descr          => 'Jenkins',
        baseurl        => 'http://pkg.jenkins-ci.org/redhat',
        enabled        => '1',
        gpgcheck       => '1',
        gpgkey         => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
      }
    }

    default: {
    }

  }

}
