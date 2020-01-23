{% from "nginx/map.jinja" import mynginx with context %}

nginx_restart:
  module.wait:
    - name: service.restart
    - m_name: {{ mynginx.service }}
#    - onchanges:
#      - nginx_server_config
#      - nginx_webpage_config
#      - nginx_webpage_available