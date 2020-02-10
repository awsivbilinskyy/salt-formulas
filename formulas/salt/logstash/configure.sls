{%- from "logstash/map.jinja" import logstash with context %}

logstash_yml_file:
  file.managed:
  - name: /etc/logstash/logstash.yml
  - source: salt://logstash/files/logstash.yml
  - template: jinja

logstash_configuration_file:
  file.managed:
  - name: /etc/logstash/logstash.conf
  - source: salt://logstash/files/logstash.conf
  - template: jinja

logstash_service:
  service.running:
  - enable: true
  - name: {{ logstash.service }}
  - watch:
    - file:
      - logstash_configuration_file
      - logstash_yml_file