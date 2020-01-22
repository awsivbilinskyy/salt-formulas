{% from "salt-formulas/map.jinja" import mysqlset with context %}

include:
  - salt-formulas.restart
mysql_server_config:
  file.managed:
    - name: {{ mysqlset.server_conf }}
    - source: {{ mysqlset.server_conf_source }}
    - require:
      - pkg: {{ mysqlset.servertype }}
