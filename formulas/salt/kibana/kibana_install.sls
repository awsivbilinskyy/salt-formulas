{%- from "kibana/map.jinja" import server with context %}
{% if grains['os_family'] == 'Debian' %}
elasticsearch_repository:
  pkgrepo.managed:
    - humanname: elasticsearch_repository
    - baseurl: deb https://artifacts.elastic.co/packages/7.x/apt
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

{% for package in server.pkgs %}
install_{{ package }}_package:
  pkg.installed:
  - name: {{ package }}
{% endfor %}