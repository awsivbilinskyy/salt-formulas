{%- from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_default:
  file.managed:
  - name: /etc/default/elasticsearch
  - source: salt://elasticsearch/files/v5/elasticsearch
  - template: jinja

elasticsearch_config:
  file.managed:
  - name: /etc/elasticsearch/elasticsearch.yml
  - source: salt://elasticsearch/files/v5/elasticsearch.yaml
  - template: jinja

elasticsearch_logging:
  file.managed:
  - name: /etc/elasticsearch/log4j2.properties
  - source: salt://elasticsearch/files/v5/log4j2.properties
  - template: jinja

elasticsearch_jvm_options:
  file.managed:
  - name: /etc/elasticsearch/jvm.options
  - source: salt://elasticsearch/files/v5/jvm.options
  - template: jinja

{%- if grains.get('init') == 'systemd' %}
elasticsearch_override_limit_memlock_file:
  file.managed:
  - name: /etc/systemd/system/elasticsearch.service.d/override.conf
  - makedirs: True
  - contents: |
      [Service]
      LimitMEMLOCK=infinity
  - watch_in:
    - module: elasticsearch_restart_systemd

elasticsearch_restart_systemd:
  module.wait:
  - name: service.systemctl_reload
  - watch_in:
    - service: elasticsearch_service
{%- endif %}

{% for dir in elasticsearch.directorylist %}
chmod_{{dir}}:
  file.directory:
    - name: {{ dir }}
    - user: {{ elasticsearch.elasticsearch_user }}
    - group: {{ elasticsearch.elasticsearch_group }}
    - dir_mode: 755
    - file_mode: 744
    - recurse:
      - user
      - group
      - mode
{% endfor %}

{% for file in elasticsearch.filelist %}
chmod_{{file}}:
  file.managed:
    - name: {{ file }}
    - user: {{ elasticsearch.elasticsearch_user }}
    - group: {{ elasticsearch.elasticsearch_group }}
    - mode: 744
    - replace: False
{% endfor %}

elasticsearch_service:
  service.running:
  - enable: true
  - name: {{ elasticsearch.service }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: elasticsearch_config
    - file: elasticsearch_logging
    - file: elasticsearch_default