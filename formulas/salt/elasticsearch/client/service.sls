{%- from "elasticsearch/map.jinja" import client with context %}

{% for pkg in client.pkgs %}
elasticsearch_client_packages_{{ pkg }}:
  pkg.installed:
  - names: {{ pkg }}
{% endfor %}