# Class: jenkins::install
#
# This class installs jenkins
#
# == Variables
#
# Refer to jenkins class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by jenkins main class.
#
class jenkins::install inherits jenkins {

  case $jenkins::install {

    package: {
      require jenkins::repository
      package { 'jenkins':
        ensure => $jenkins::manage_package,
        name   => $jenkins::package,
      }
    }

    source: {
      puppi::netinstall { 'jenkins':
        url                 => $jenkins::install_source,
        destination_dir     => $jenkins::install_destination,
        extract_command     => 'rsync',
        preextract_command  => $jenkins::install_precommand,
        postextract_command => $jenkins::install_postcommand,
      }
    }

    puppi: {
      puppi::project::war { 'jenkins':
        source                   => $jenkins::install_source,
        deploy_root              => $jenkins::install_destination,
        predeploy_customcommand  => $jenkins::install_precommand,
        postdeploy_customcommand => $jenkins::install_postcommand,
        report_email             => 'root',
        auto_deploy              => true,
        check_deploy             => false,
        run_checks               => false,
        enable                   => true,
      }
    }

    default: {
    }

  }

}
