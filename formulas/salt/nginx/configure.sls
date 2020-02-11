{% from "nginx/map.jinja" import mynginx with context %}

nginx_server_config:
  file.managed:
    - name: {{ mynginx.server_conf }}
    - source: {{ mynginx.server_conf_source }}
    - require:
      - pkg: nginx

nginx_webpage_config:
  file.managed:
    - name: {{ mynginx.default_page }}
    - source: {{ mynginx.default_page_source }}
    - require:
      - pkg: nginx

{% if grains['os_family'] == 'Debian' %}

nginx_webpage_available:
  file.managed:
    - name: /etc/nginx/sites-available/default
    - source: {{ mynginx.server_conf_source }}
    - require:
      - pkg: nginx

{% endif %}

nginx_restarting_configure:
  service.running:
  - enable: true
  - name: {{ mynginx.service }}
  - watch:
    - file: nginx_server_config
    - file: nginx_webpage_config
{% if grains['os_family'] == 'Debian' %}
    - file: nginx_webpage_available
{% endif %}