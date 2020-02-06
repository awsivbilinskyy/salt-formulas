{%- from "kibana/map.jinja" import kibana with context %}

uptodate_apt_for_kibana:
  pkg.uptodate:
    - refresh: True

{% for package in kibana.pkgs %}
install_kibana_{{ package }}:
  pkg.installed:
  - name: {{ package }}
{% endfor %}