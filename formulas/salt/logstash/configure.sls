{%- from "logstash/map.jinja" import logstash with context %}

logstash_config_file:
  file.managed:
  - name: /etc/logstash/logstash.yml
  - source: salt://logstash/files/logstash.yml
  - template: jinja

logstash_service:
  service.running:
  - enable: true
  - name: {{ logstash.service }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file:
      - logstash_config_file