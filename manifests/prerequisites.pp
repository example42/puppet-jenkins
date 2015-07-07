# Class: jenkins::prerequisites
#
# This class installs jenkins prerequisites
#
# == Variables
#
# Refer to jenkins class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by jenkins if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class jenkins::prerequisites {

  if $jenkins::install == package {
    case $::operatingsystem {
      /(?i:RedHat|CentOS)/: { include yum::repo::jenkins }
      /(?i:Debian|Ubuntu|Mint)/: { include apt::repo::jenkins }
      default: {}
    }
  }
}
