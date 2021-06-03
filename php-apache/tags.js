const common = [
    'bcmath', 'bz2', 'calendar', 'exif', 'iconv', 'intl', 'gd', 'ldap',
  'mbstring', 'memcached', 'mysql', 'mysqli', 'pdo_mysql', 'pdo_pgsql',
  'pgsql', 'redis', 'soap', 'opcache', 'zip'
];

const WP_CLI_VERSION = '2.5.0';

module.exports = {
  "5.6": {
    "args": {
      "PHP_VERSION": "5.6",
      WP_CLI_VERSION,
      "IMAGICK_VERSION": "3.4.4",
      "MODULES": [...common, 'mcrypt', 'ioncube', 'mysql'].sort().join(" "),
      "IONCUBE": true,
    }
  },
  "7.2": {
    "args": {
      "PHP_VERSION": "7.2",
      "MODULES": [...common, 'mcrypt', 'ioncube', 'mysql'].sort().join(" "),
      WP_CLI_VERSION,
      "IMAGICK_VERSION": "3.4.4",
      "IONCUBE": true,
    }
  },
  "7.3": {
    "args": {
      "PHP_VERSION": "7.3",
      "MODULES": [...common, 'mcrypt', 'ioncube', 'mysql'].sort().join(" "),
      WP_CLI_VERSION,
      "IMAGICK_VERSION": "3.4.4",
      "IONCUBE": true,
    }
  },
  "7.4": {
    "args": {
      "PHP_VERSION": "7.4",
      "MODULES": [...common, 'mcrypt', 'mysql'].sort().join(" "),
      WP_CLI_VERSION,
      "IMAGICK_VERSION": "3.4.4",
      "IONCUBE": true,
    },
    "packages": ["php"],
  },
  "8.0": {
    "args": {
      "PHP_VERSION": "8.0",
      "MODULES": [...common, 'mcrypt', 'mysql'].sort().join(" "),
      WP_CLI_VERSION,
      "IMAGICK_VERSION": "3.4.4",
      "IONCUBE": false,
      "IMAGICK_GIT": true,
    },
    "latest": true,
    "packages": ["php"],
  },
};
