{% if grains['os_family'] == 'RedHat' %}

firewall_service_down:
  service.dead:
    - name: firewalld
    - enable: False

{% elif grains['os_family'] == 'Debian' %}

ufw_service_down:
  service.dead:
    - name: ufw
    - enable: False

{% endif %}