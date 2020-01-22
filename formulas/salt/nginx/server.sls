{% if grains['os_family'] == 'RedHat' %}

epel_release_install:
  pkg.installed:
    - name: epel-release

{% endif %}

nginx_server_install:
  pkg.installed:
    - name: nginx