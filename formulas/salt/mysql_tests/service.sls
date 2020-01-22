{% from "mysql/map.jinja" import mysqlset with context %}

mysql_service_enable:
  service.running:
    - name: {{ mysqlset.service }}
