{%- from "kibana/map.jinja" import server with context %}
{% if grains['os_family'] == 'Debian' %}
kibana_ubuntu_repository:
  pkgrepo.managed:
    - humanname: kibana_repository
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - file: /etc/apt/sources.list.d/kibana.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

{% if grains['os_family'] == 'RedHat' %}
kibana_centos_repository:
  pkgrepo.managed:
    - humanname: kibana_repository
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