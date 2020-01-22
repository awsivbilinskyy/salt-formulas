{% from "nginx/map.jinja" import mynginx with context %}

nginx_service_enable:
  service.running:
    - name: {{ mynginx.service }}
    - enable: true
