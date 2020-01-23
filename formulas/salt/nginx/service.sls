{% from "nginx/map.jinja" import mynginx with context %}

nginx:
  service.running:
    - name: {{ mynginx.service }}
    - enable: True
    - reload: True
