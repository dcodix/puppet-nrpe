define nrpe::ownplugins ( $plugin=$title ) {
  file { "$nrpe::params::plugindir/$plugin" :
    source => "puppet:///modules/nrpe/plugins/$plugin",
    owner => root, group => root, mode => 755,
  }
}

