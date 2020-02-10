{%- from "filebeat/map.jinja" import filebeat with context %}

{% if grains['os_family'] == 'Debian' %}
filebeat_repository:
  pkgrepo.managed:
    - humanname: filebeat_repository
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/filebeat.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

{% if grains['os_family'] == 'RedHat' %}
filebeat_centos_repository:
  pkgrepo.managed:
    - humanname: filebeat_repository
    - baseurl: https://artifacts.elastic.co/packages/7.x/yum
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

uptodate_apt_for_filebeat:
  pkg.uptodate:
    - refresh: True

{% for package in filebeat.pkgs %}
install_filebeat_{{ package }}:
  pkg.installed:
  - name: {{ package }}
{% endfor %}