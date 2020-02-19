{%- from "apache2bastion/map.jinja" import apache2bastion with context %}

uptodate_repos_for_apache2:
  pkg.uptodate:
    - refresh: True

{% for package in apache2bastion.pkgs %}
install_apache2_{{ package }}:
  pkg.installed:
  - name: {{ package }}
{% endfor %}

apache2 Service:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pkg: apache2

{% for module in apache2bastion.apache2modules %}
Enable_{{ module }}_module:
  apache_module.enabled:
    - name: {{ module }}
{% endfor %}

