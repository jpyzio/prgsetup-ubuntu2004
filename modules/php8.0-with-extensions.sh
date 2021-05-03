#!/usr/bin/env bash

add-apt-repository --yes ppa:ondrej/php

apt install --yes --no-install-recommends php8.0-gd php8.0-intl php8.0-mysql php8.0-phpdbg php8.0-snmp \
    php8.0-tidy php8.0-zip php8.0 php8.0-cli php8.0-dev php8.0-gmp php8.0-odbc php8.0-pspell php8.0-soap \
    php8.0-xml php8.0-bcmath php8.0-common php8.0-enchant php8.0-imap php8.0-ldap php8.0-opcache php8.0-readline \
    php8.0-sqlite3 php8.0-xmlrpc php8.0-bz2 php8.0-curl php8.0-interbase php8.0-mbstring php8.0-pgsql php8.0-sybase \
    php8.0-xsl php-xdebug php-memcached php-imagick php-mongodb
