{%- from "elasticsearch/map.jinja" import elasticsearch with context %}

{% if grains['os_family'] == 'Debian' %}
elasticsearch_repository:
  pkgrepo.managed:
    - humanname: elasticsearch_repository
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

{% if grains['os_family'] == 'RedHat' %}
elasticsearch_centos_repository:
  pkgrepo.managed:
    - humanname: elasticsearch_repository
    - baseurl: https://artifacts.elastic.co/packages/7.x/yum
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

uptodate_apt:
  pkg.uptodate:
    - refresh: True

{% for package in elasticsearch.pkgs %}
install_{{ package }}_package:
  pkg.installed:
  - name: {{ package }}
{% endfor %}

