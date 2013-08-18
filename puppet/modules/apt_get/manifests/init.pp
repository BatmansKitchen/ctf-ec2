class apt_get {
  $packages = [
    'emacs23-nox',
    'facter',
    'git',
    'puppet',
    'zsh',
  ]
  
  package { 'packages':
    ensure   => latest,
    provider => 'apt',
    name     => $packages,
    require  => Exec['apt-get update']
  }

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}
