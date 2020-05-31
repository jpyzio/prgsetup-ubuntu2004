#!/usr/bin/env bash

### BEGIN PHP7.4
sudo apt install --yes  --no-install-recommends php7.4-gd php7.4-intl php7.4-mysql php7.4-phpdbg php7.4-snmp \
  php7.4-tidy php7.4-zip php7.4 php7.4-cli php7.4-dev php7.4-gmp php7.4-json php7.4-odbc php7.4-pspell php7.4-soap \
  php7.4-xml php7.4-bcmath php7.4-common php7.4-enchant php7.4-imap php7.4-ldap php7.4-opcache php7.4-readline \
  php7.4-sqlite3 php7.4-xmlrpc php7.4-bz2 php7.4-curl php7.4-interbase php7.4-mbstring php7.4-pgsql php7.4-sybase \
  php7.4-xsl php-xdebug php-memcached php-imagick php-mongodb
### END PHP7.4

### BEGIN Composer
curl --silent https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
### END Composer

### BEGIN Composer global tools
echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" | tee --append ~/.zshrc ~/.bashrc

composer global require phpunit/phpunit phing/phing sebastian/phpcpd phploc/phploc phpmd/phpmd squizlabs/php_codesniffer phpstan/phpstan
### END Composer global tools

### BEGIN Framework installers
echo "export PATH=\"\$HOME/.symfony/bin:\$PATH\"" | tee --append ~/.zshrc ~/.bashrc

curl -sS https://get.symfony.com/cli/installer | bash
composer global require laravel/installer laravel/lumen-installer
### END Framework installers
