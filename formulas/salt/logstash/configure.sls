{%- from "logstash/map.jinja" import logstash with context %}

logstash_yml_file:
  file.managed:
  - name: /etc/logstash/logstash.yml
  - source: salt://logstash/files/logstash.yml
  - template: jinja

logstash_jvm_configuration_file:
  file.managed:
  - name: /etc/logstash/jvm.options
  - source: salt://logstash/files/jvm.options
  - template: jinja

logstash_configuration_file:
  file.managed:
  - name: /etc/logstash/conf.d/filebeat.conf
  - source: salt://logstash/files/logstash.conf
  - template: jinja

{% for filters in logstash.applied_filters %}
logstash_filters_{{ filters }}:
  file.managed:
  - name: /etc/logstash/conf.d/{{ filters }}.conf
  - source: salt://logstash/files/filters/{{ filters }}.conf
  - template: jinja
{% endfor %}

{% if logstash.collection_directory_list is defined and logstash.collection_directory_list|length %}
{% for dir in logstash.collection_directory_list %}
chmod_{{dir}}:
  file.directory:
    - name: {{ dir }}
    - user: {{ logstash.logstash_user }}
    - group: {{ logstash.logstash_group }}
    - dir_mode: 755
    - file_mode: 744
    - recurse:
      - user
      - group
      - mode
{% endfor %}
{% endif %}

{% for file in logstash.file_collection_logs %}
chmod_{{ file }}:
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