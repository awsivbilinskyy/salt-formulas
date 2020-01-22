{% if grains['os_family'] == 'Debian' %}
selinux_policy_utils_install:
  pkg.installed:
    - name: policycoreutils

selinux_policy_install:
  pkg.installed:
    - name: selinux-policy-default

{% elif grains['os_family'] == 'RedHat' %}

permissive:
  selinux.mode:
    - require:
      - pkg: policy-packages

policy-packages:
  pkg.installed:
    - pkgs:
      - policycoreutils-python
      - selinux-policy-targeted

{% endif %}