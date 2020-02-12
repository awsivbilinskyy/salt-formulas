{% from "nginx/map.jinja" import mynginx with context %}
uptodate_apt_for_nginx:
  pkg.uptodate:
    - refresh: True

{% if grains['os_family'] == 'RedHat' %}

epel_release_install:
  pkg.installed:
    - name: epel-release

{% endif %}

nginx_server_install:
  pkg.installed:
    - name: nginx