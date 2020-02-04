{%- from "elasticsearch/map.jinja" import server with context %}

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

elasticsearch_default:
  file.managed:
  - name: /etc/default/elasticsearch
  - source: salt://elasticsearch/files/v{{ server.version }}/elasticsearch
  - template: jinja
  - require:
    - pkg: elasticsearch_packages

elasticsearch_config:
  file.managed:
  - name: /etc/elasticsearch/elasticsearch.yml
  - source: salt://elasticsearch/files/v{{ server.version }}/elasticsearch.yml
  - template: jinja
  - require:
    - pkg: elasticsearch_packages

elasticsearch_logging:
  file.managed:
  - name: /etc/elasticsearch/log4j2.properties
  - source: salt://elasticsearch/files/v5/log4j2.properties
  - template: jinja
  - require:
    - pkg: elasticsearch_packages

elasticsearch_jvm_options:
  file.managed:
  - name: /etc/elasticsearch/jvm.options
  - source: salt://elasticsearch/files/v5/jvm.options
  - template: jinja
  - require:
    - pkg: elasticsearch_packages

{%- if grains.get('init') == 'systemd' %}
elasticsearch_override_limit_memlock_file:
  file.managed:
  - name: /etc/systemd/system/elasticsearch.service.d/override.conf
  - makedirs: True
  - contents: |
      [Service]
      LimitMEMLOCK=infinity
  - require:
    - pkg: elasticsearch_packages
  - watch_in:
    - module: elasticsearch_restart_systemd
elasticsearch_restart_systemd:
  module.wait:
  - name: service.systemctl_reload
  - watch_in:
    - service: elasticsearch_service
{%- endif %}

elasticsearch_service:
  service.running:
  - enable: true
  - name: {{ server.service }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: elasticsearch_config
    - file: elasticsearch_logging
    - file: elasticsearch_default
