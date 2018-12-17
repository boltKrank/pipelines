class { '::mysql::server':
  root_password           => 'puppetlabs',
  remove_default_accounts => true,
}

mysql::db { 'cd4pe':
  user     => 'cd4pe',
  password => 'puppetlabs',
  host     => 'localhost',
  grant    => ['ALL PRIVILEGES'],
}
