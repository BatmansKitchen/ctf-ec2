define users::adduser($id, $shell = "/bin/bash", $groups = [], $username = $title) {
  user { $username:
      shell      => $shell,
      home       => $home,
      managehome => "true",
      uid        => $id,
      groups     => $groups,
      membership => inclusive,
  }

  file { "/home/${username}":
      ensure  => directory,
      recurse => remote,
      owner   => $username,
      group   => $username,
      source  => "puppet:///modules/users/userfiles/$username",
      mode    => "0644",
  }
}
