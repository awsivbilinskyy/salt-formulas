{%- from "elasticsearch/map.jinja" import server with context %}

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}