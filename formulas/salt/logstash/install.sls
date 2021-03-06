{%- from "logstash/map.jinja" import logstash with context %}

{% if grains['os_family'] == 'Debian' %}
logstash_repository:
  pkgrepo.managed:
    - humanname: logstash_repository
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/logstash.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

{% if grains['os_family'] == 'RedHat' %}
logstash_centos_repository:
  pkgrepo.managed:
    - humanname: logstash_repository
    - baseurl: https://artifacts.elastic.co/packages/7.x/yum
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% endif %}

uptodate_apt_for_logstash:
  pkg.uptodate:
    - refresh: True

{% for package in logstash.pkgs %}
install_logstash_{{ package }}:
  pkg.installed:
  - name: {{ package }}
{% endfor %}