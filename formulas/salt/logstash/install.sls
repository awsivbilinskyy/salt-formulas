{%- from "logstash/map.jinja" import logstash with context %}

{% if grains['os_family'] == 'Debian' %}
logstash-repo-key:
  cmd.run:
    - name: wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
    - unless: apt-key list | grep 'Elasticsearch (Elasticsearch Signing Key)'

logstash-repo:
  pkgrepo.managed:
    - humanname: Logstash Debian Repository
    - name: deb http://packages.elasticsearch.org/logstash/{{ logstash.version }}/debian stable main
    - require:
      - cmd: logstash-repo-key

{% elif grains['os_family'] == 'RedHat' %}
logstash-repo-key:
  cmd.run:
    - name:  rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - unless: rpm -qi gpg-pubkey-d88e42b4-52371eca

logstash-repo:
  pkgrepo.managed:
    - humanname: logstash repository for {{ logstash.version }}.x packages
    - baseurl: http://packages.elasticsearch.org/logstash/{{ logstash.version }}/centos
    - gpgcheck: 1
    - gpgkey: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - enabled: 1
    - require:
      - cmd: logstash-repo-key
{% endif %}

uptodate_apt_for_logstash:
  pkg.uptodate:
    - refresh: True

{% for package in logstash.pkgs %}
install_logstash_{{ package }}:
  pkg.installed:
  - name: {{ package }}
{% endfor %}