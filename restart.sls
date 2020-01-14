{% from "salt-formulas/map.jinja" import mysqlset with context %}

mysql_restart:
  module.wait:
    - name: service.restart
    - m_name: {{ mysqlset.service }}
    - onchanges:
      - mysql_server_config
