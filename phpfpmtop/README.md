# PHP-FPM TOP

This script uses php-fpm status page and performs a simple grep sort uniq to
list out the php pages being accessed constantly.

## Requirements

1. php-fpm status page enabled in config file.

  REF:  https://rtcamp.com/tutorials/php/fpm-status-page/

  uncomment the line by using vim
    ```vim +/pm.status_path /etc/php5/fpm/pool.d/www.conf```

2. Debian 
  1. apt-get install libfcgi0ldbl
3. Redhat / RPM
  2. yum --enablerepo=epel install fcgi 


## Credits
Credits where credit is due. (Links i refered while whipping this script)

1. Initial portion taken from https://rtcamp.com/tutorials/php/directly-connect-php-fpm/
2. http://www.thatsgeeky.com/2012/02/directly-connecting-to-php-fpm/


