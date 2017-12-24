# == Class: lsyncd::params
#
# This class manages lsyncd parameters
#
#
class lsyncd::params {

    $config_file_template = 'lsyncd/lsyncd_default.erb'
    $lsyncd_pkg           = 'lsyncd'
    $lsyncd_service       = 'lsyncd'
    $conf_file_path       = '/etc/lsyncd.conf'

    case $::osfamily {
        'RedHat': {}
        default: {
            fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
    }
}
