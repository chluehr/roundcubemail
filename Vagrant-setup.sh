#!/bin/bash

    echo  "==== BEGIN: Vagrant-setup.sh ===="

    apt-get -qq update

    DEBIAN_FRONTEND=noninteractive          \
	apt-get -qq --assume-yes install    \
        vim                                 \
        mysql-server                        \
        libapache2-mod-php5                 \
        php5-mysql                          \
        php5-intl                           \
        php5-mcrypt

    # configure PHP timezone
    echo "[Date]"                         > /etc/php5/conf.d/date.ini
    echo "date.timezone = Europe/Berlin" >> /etc/php5/conf.d/date.ini

    # restart apache
    apache2ctl graceful

    # prepare roundcube
    chmod --recursive a+rw /var/www/temp
    chmod --recursive a+rw /var/www/logs

    # configure roundcube (instead of installer)
    cp /var/www/config/main.inc.php.dist /var/www/config/main.inc.php
    cp /var/www/config/db.inc.php.dist   /var/www/config/db.inc.php

    # create database w/ default roundcube settings
    echo "CREATE DATABASE IF NOT EXISTS roundcubemail" | mysql
    echo "GRANT ALL PRIVILEGES ON roundcubemail.* 
          TO 'roundcube'@'localhost' IDENTIFIED BY 'pass'" | mysql

    # import initial DB structure
    mysql roundcubemail </var/www/db-dump.sql

    echo "==== DONE ===="
    exit 0

# eof
