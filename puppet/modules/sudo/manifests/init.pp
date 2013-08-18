class sudo {
  package { "sudo": }

  # Make sure about root:root since sudo is so touchy
  File {
    owner =>  "root",
    group => "root",
    require => Package["sudo"],
  }

  file { "/etc/sudoers":
    mode   => "0440",
    source => "puppet:///modules/sudo/sudoers",
  }
}
