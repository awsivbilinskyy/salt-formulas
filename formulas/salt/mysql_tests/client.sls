{% from "salt-formulas/map.jinja" import mysqlset with context %}

mysql_client_install:
  pkg.installed:
    - name: {{ mysqlset.client }}
