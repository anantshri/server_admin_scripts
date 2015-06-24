watch 'SCRIPT_NAME=/status SCRIPT_FILENAME=/status QUERY_STRING=full REQUEST_METHOD=GET cgi-fcgi -bind -connect /var/run/php5-fpm.sock | grep "script" | sort | uniq -c'
