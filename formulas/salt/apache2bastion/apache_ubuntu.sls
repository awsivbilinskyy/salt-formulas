{%- from "apache2bastion/map.jinja" import apache2bastion with context %}

Turn Off KeepAlive:
  file.replace:
    - name: /etc/apache2/apache2.conf
    - pattern: 'KeepAlive On'
    - repl: 'KeepAlive Off'
    - show_changes: True

/etc/apache2/conf-available/tune_apache.conf:
  file.managed:
    - source: salt://apache2bastion/files/tune_apache.conf

Enable tune_apache:
  apache_conf.enabled:
    - name: tune_apache

/var/www/html/{{ apache2bastion.webservice }}:
  file.directory

/var/www/html/{{ apache2bastion.webservice }}/log:
  file.directory

/var/www/html/{{ apache2bastion.webservice }}/backups:
  file.directory

/var/www/html/{{ apache2bastion.webservice }}/public_html:
  file.directory

000-default:
  apache_site.disabled

/etc/apache2/sites-available/{{ apache2bastion.webservice }}.conf:
  apache.configfile:
    - config:
      - VirtualHost:
          - this: '*:80'
          - ServerName:
              - {{ apache2bastion.webservice }}
          - ServerAlias:
              - www.{{ apache2bastion.webservice }}
          - DocumentRoot: /var/www/html/{{ apache2bastion.webservice }}/public_html
          - ErrorLog: /var/www/html/{{ apache2bastion.webservice }}/log/error.log
          - CustomLog: /var/www/html/{{ apache2bastion.webservice }}/log/access.log combined
          - SSLProxyEngine: On
          - SSLProxyVerify: none
          - SSLProxyCheckPeerCN: off
          - SSLProxyCheckPeerName: off
          - SSLProxyCheckPeerExpire: off
          - ProxyPreserveHost: off
          - Location:
            - this: /kibana
            - ProxyPass: http://192.168.56.43:80/
            - ProxyPassReverse: http://192.168.56.43:80/
            - Order: allow,deny
            - Allow: from all
          - Location:
            - this: /web1
            - ProxyPass: http://192.168.56.41:80/
            - ProxyPassReverse: http://192.168.56.41:80/
            - Order: allow,deny
            - Allow: from all

{{ apache2bastion.webservice }}:
  apache_site.enabled

/var/www/html/{{ apache2bastion.webservice }}/public_html/index.html:
  file.managed:
    - source: salt://apache2bastion/files/index.html

apache2_service_restart:
  service.running:
  - enable: true
  - name: {{ apache2bastion.servicename }}
  - watch:
    - file: /etc/apache2/sites-available/{{ apache2bastion.webservice }}.conf
    - file: /var/www/html/{{ apache2bastion.webservice }}/public_html/index.html
    - file: /etc/apache2/conf-available/tune_apache.conf
