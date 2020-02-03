{% from "elasticsearch/map.jinja" import base_defaults with context %}

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}