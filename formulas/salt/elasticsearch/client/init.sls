{%- from "elasticsearch/map.jinja" import client with context %}

include:
  - elasticsearch.client.service

#elasticsearch_check_cluster_status_before_creating_index_{{ index_name }}:
#  cmd.run:
#  - name: curl -sf {{ client.server.host }}:{{ client.server.port }}/_cat/health | awk '{print $4}' | grep green
#  - retry:
#      attempts: 5
#      until: True
#      interval: 10
#      splay: 5
