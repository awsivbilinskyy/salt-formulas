{%- from "kibana/map.jinja" import kibana with context %}

include:
  - nginx

reconfigure_kibana_proxy:
  file.managed:
  - name: /etc/nginx/conf.d/service.conf
  - source: salt://kibana/files/service.conf
  - template: jinja

kibana_proxy_restart:
  service.running:
  - enable: True
  - name: nginx
  - reload: True
  - watch:
    - file: reconfigure_kibana_proxy