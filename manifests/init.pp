# Class: lsyncd
#
# This class manages lsyncd.
#
# Parameters:
#
# [*config_file_template*]
#   String. Main configuration file template
#   Default: lsyncd/lsyncd_default.erb
#
# [*lsyncd_pkg*]
#   String. Lsyncd pkg name
#   Default: lsyncd
#
# [*lsyncd_service*]
#   String. Lsyncd service name
#   Default: lsyncd
#
# [*conf_file_path*]
#   String. Lsyncd configuration file path
#   Default: /etc/lsyncd.conf
#
class lsyncd (
    $config_file_template = $::lsyncd::params::config_file_template,
    $lsyncd_pkg           = $::lsyncd::params::lsyncd_pkg,
    $lsyncd_service       = $::lsyncd::params::lsyncd_service,
    $conf_file_path       = $::lsyncd::params::conf_file_path,
) inherits lsyncd::params {

    package { $lsyncd_pkg:
        ensure => 'present',
    }

    service { $lsyncd_service:
        ensure    => 'running',
        enable    => true,
        hasstatus => true,
        require   => Package[$lsyncd_pkg],
    }

    file { $conf_file_path:
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template($config_file_template),
        require => Package[$lsyncd_pkg],
        notify  => Service[$lsyncd_service],
    }

    file { '/etc/sysconfig/lsyncd':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('lsyncd/lsyncd.erb'),
        require => Package[$lsyncd_pkg],
        notify  => Service[$lsyncd_service],
    }

}
