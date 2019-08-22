const common = [
    'bcmath', 'bz2', 'calendar', 'exif', 'iconv', 'intl', 'gd', 'ldap',
  'mbstring', 'memcached', 'mysql', 'mysqli', 'pdo_mysql', 'pdo_pgsql',
  'pgsql', 'redis', 'soap', 'opcache', 'zip', 'ioncube'
];

module.exports = {
  "5.6": {
    "args": {
      "PHP_VERSION": "5.6",
      "WP_CLI_VERSION": "2.1.0",
      "IMAGICK_VERSION": "3.4.4",
      "MODULES": [...common, 'mcrypt', 'mysql'].sort().join(" ")
    }
  },
  "7.2": {
    "args": {
      "PHP_VERSION": "7.2",
      "MODULES": [...common, 'mcrypt', 'mysql'].sort().join(" "),
      "WP_CLI_VERSION": "2.1.0",
      "IMAGICK_VERSION": "3.4.4",
    }
  }
  "7.3": {
    "args": {
      "PHP_VERSION": "7.3",
      "MODULES": [...common, 'mcrypt', 'mysql'].sort().join(" "),
      "WP_CLI_VERSION": "2.1.0",
      "IMAGICK_VERSION": "3.4.4",
    }
  }
};
