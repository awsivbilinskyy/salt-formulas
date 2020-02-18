{%- from "apache2bastion/map.jinja" import apache2bastion with context %}
apache2:
  pkg.installed

apache2 Service:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pkg: apache2

Turn Off KeepAlive:
  file.replace:
    - name: /etc/apache2/apache2.conf
    - pattern: 'KeepAlive On'
    - repl: 'KeepAlive Off'
    - show_changes: True
    - require:
      - pkg: apache2

/etc/apache2/conf-available/tune_apache.conf:
  file.managed:
    - source: salt://apache2bastion/files/tune_apache.conf
    - require:
      - pkg: apache2

Enable tune_apache:
  apache_conf.enabled:
    - name: tune_apache
    - require:
      - pkg: apache2

/var/www/html/{{ apache2bastion.webservice }}:
  file.directory

/var/www/html/{{ apache2bastion.webservice }}/log:
  file.directory

/var/www/html/{{ apache2bastion.webservice }}/backups:
  file.directory

/var/www/html/{{ apache2bastion.webservice }}/public_html:
  file.directory

000-default:
  apache_site.disabled:
    - require:
      - pkg: apache2

/etc/apache2/sites-available/{{ apache2bastion.webservice }}.conf:
  apache.configfile:
    - config:
      - VirtualHost:
          this: '*:80'
          ServerName:
            - {{ apache2bastion.webservice }}
          ServerAlias:
            - www.{{ apache2bastion.webservice }}
          DocumentRoot: /var/www/html/{{ apache2bastion.webservice }}/public_html
          ErrorLog: /var/www/html/{{ apache2bastion.webservice }}/log/error.log
          CustomLog: /var/www/html/{{ apache2bastion.webservice }}/log/access.log combined

{{ apache2bastion.webservice }}:
  apache_site.enabled:
    - require:
      - pkg: apache2

/var/www/html/{{ apache2bastion.webservice }}/public_html/index.html:
  file.managed:
    - source: salt://apache2bastion/files/index.html