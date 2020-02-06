{%- from "kibana/map.jinja" import kibana with context %}

kibana_config_file:
  file.managed:
  - name: /etc/kibana/kibana.yml
  - source: salt://kibana/files/kibana.yml
  - template: jinja

kibana_service:
  service.running:
  - enable: true
  - name: {{ kibana.service }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: kibana_config_file