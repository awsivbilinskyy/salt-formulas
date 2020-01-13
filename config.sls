include:
  - salt-formulas.restart
mysql_server_config:
  file.managed:
    - name: /etc/my.cnf.d/server.cnf
    - source: salt://salt-formulas/files/server.cnf
