{%- from "apache2bastion/map.jinja" import apache2bastion with context %}
{% for module in apache2bastion.apache2modules %}
Enable_{{ module }}_module:
  apache_module.enabled:
    - name: {{ module }}
{% endfor %}
