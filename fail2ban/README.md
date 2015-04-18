# fail2ban config files.

## mail-whois-shodan-lines.conf
This configuration leverages the shodan api via https://github.com/anantshri/script-collection/blob/master/shodan_hostenum.py
So to get this working following steps are required

1) Install shodan python api
`easy_install shodan`
2) download and place shodan_hostenum.py at proper location. (/usr/bin/ in current example)
3) configure shodan API key in the python file.
4) Add mail-whois-shodan-lines.conf in actions.d
5) configure the action setting.
