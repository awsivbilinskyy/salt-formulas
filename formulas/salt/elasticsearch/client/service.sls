{%- from "elasticsearch/map.jinja" import client with context %}

{% for pkg in client.pkgs %}
elasticsearch_client_packages_{{ pkgs }}:
  pkg.installed:
  - names: {{ pkgs }}
{% endfor %}