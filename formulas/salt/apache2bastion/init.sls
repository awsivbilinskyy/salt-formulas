include:
{% if grains['os_family'] == 'RedHat' %}
  - apache2bastion.apache_centos
{% endif %}
{% if grains['os_family'] == 'Debian' %}
  - apache2bastion.apache_ubuntu
{% endif %}