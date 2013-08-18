class ctf {

  # All CTF content
  file { "/var/ctf":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => "0644",
  }

  # Competition directories
  file { "/var/ctf/competitions":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => "0644",
  }

  # Input files for competitions
  file { "/var/ctf/competition_data":
    ensure => "directory",
    owner  => "root",
    group  => "admin",
    mode   => "0664",
  }

  # Common utilities
  file { "/var/ctf/tools":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => "0644",
  }
}
