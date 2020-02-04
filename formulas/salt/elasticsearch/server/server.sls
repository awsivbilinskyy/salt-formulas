{%- from "elasticsearch/map.jinja" import server with context %}

{% if grains['os_family'] == 'Debian' %}
elasticsearch_repository:
  pkgrepo.managed:
    - humanname: elasticsearch_repository
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.repo
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

uptodate_apt:
  pkg.uptodate:
    - refresh: True

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

#jre_packages:
#  pkg.installed:
#  - name: default-jre-headless

#elasticsearch_packages:
#  pkg.installed:
#  - name: elasticsearch

{% endif %}

{% if grains['os_family'] == 'RedHat' %}
elasticsearch_centos_repository:
  pkgrepo.managed:
    - humanname: elasticsearch_repository
    - baseurl: https://artifacts.elastic.co/packages/7.x/yum
#    - baseurl: https://artifacts.elastic.co/packages/oss-7.x/yum
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch

uptodate_apt:
  pkg.uptodate:
    - refresh: True

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

#java_open_packages:
#  pkg.installed:
#  - name: java-1.8.0-openjdk

#java_devel_packages:
#  pkg.installed:
#  - name: java-1.8.0-openjdk-devel

#elasticsearch_packages:
#  pkg.installed:
#  - name: elasticsearch-oss
{% endif %}

