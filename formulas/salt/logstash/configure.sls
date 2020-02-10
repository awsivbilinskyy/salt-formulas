{%- from "logstash/map.jinja" import logstash with context %}

logstash_yml_file:
  file.managed:
  - name: /etc/logstash/logstash.yml
  - source: salt://logstash/files/logstash.yml
  - template: jinja

logstash_configuration_file:
  file.managed:
  - name: /etc/logstash/conf.d/filebeat.conf
  - source: salt://logstash/files/logstash.conf
  - template: jinja

{% for file in logstash.file_collection_logs %}
chmod_{{file}}:
  file.managed:
    - name: {{ file }}
    - mode: 755
    - replace: False
{% endfor %}

logstash_service:
  service.running:
  - enable: true
  - name: {{ logstash.service }}
  - watch:
    - file: logstash_configuration_file
    - file: logstash_yml_file