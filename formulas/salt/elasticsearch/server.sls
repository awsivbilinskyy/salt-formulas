{% from "elasticsearch/map.jinja" import mynginx with context %}

elasticsearch_packages:
  pkg.installed:
  - names: {{ server.pkgs }}