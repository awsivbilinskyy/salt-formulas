{%- from "logstash/map.jinja" import logstash with context %}

uptodate_apt_for_logstash:
  pkg.uptodate:
    - refresh: True

{% for package in logstash.pkgs %}
install_logstash_{{ package }}:
  pkg.installed:
  - name: {{ package }}
{% endfor %}