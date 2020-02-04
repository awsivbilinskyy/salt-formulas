{%- from "elasticsearch/map.jinja" import server with context %}

elasticsearch_repository:
  pkgrepo.managed:
    - humanname: elasticsearch_repository
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}