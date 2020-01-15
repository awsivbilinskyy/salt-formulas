#{% if grains['os_family'] == 'RedHat' %}
#
#mysql_root_password_set:
#  cmd.run:
#    - name: mysqladmin --host 127.0.0.1 --user {{ pillar['mysql']['root']['name'] }} password '{{ pillar['mysql']['root']['password'] }}'
#    - unless: mysql --host 127.0.0.1 --user {{ pillar['mysql']['root']['name'] }} --password '{{ pillar['mysql']['root']['password'] }}' --execute="SELECT 1;"
#
#{% endif %}

mysql_root_user:
  mysql_user.present:
    - name: {{ pillar['mysql']['root']['name'] }}
    - password: {{ pillar['mysql']['root']['password'] }}
    - host: 127.0.0.1
    - connection_pass: {{ pillar['mysql']['root']['password'] }}
