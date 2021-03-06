{%- from "elasticsearch/map.jinja" import server with context %}
elasticsearch_curator_packages:
  pkg.installed:
  - names: {{ server.curator_pkgs }}
elasticsearch_curator_config:
  file.managed:
  - name: /etc/elasticsearch/curator.yml
  - source: salt://elasticsearch/files/curator.yml
  - group: elasticsearch
  - mode: 640
  - template: jinja
  - require:
    - pkg: elasticsearch_packages
elasticsearch_curator_action_config:
  file.managed:
  - name: /etc/elasticsearch/curator_actions.yml
  - source: salt://elasticsearch/files/curator_actions.yml
  - group: elasticsearch
  - mode: 640
  - template: jinja
  - require:
    - file: elasticsearch_curator_config
elasticsearch_curator_cron:
  cron.present:
    - name: "curator --config /etc/elasticsearch/curator.yml /etc/elasticsearch/curator_actions.yml >/dev/null"
    - user: elasticsearch
    - minute: random
    - hour: 1
elasticsearch_curator_cron_path:
  cron.env_present:
    - name: PATH
    - user: elasticsearch
    - value: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    - require_in:
      - cron: elasticsearch_curator_cron
{%- if server.curator.logfile|default("") %}
elasticsearch_curator_log:
  file.managed:
  - name: {{ server.curator.logfile }}
  - user: elasticsearch
  - group: elasticsearch
{%- endif %}

