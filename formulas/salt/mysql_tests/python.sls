{% from "salt-formulas/map.jinja" import mysqlset with context %}

mysql_python_install:
  pkg.installed:
    - name: {{ mysqlset.python }}
