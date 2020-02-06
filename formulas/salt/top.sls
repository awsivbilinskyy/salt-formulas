base:
  'G@roles:salt-master':
    - selinux.selinux
  'G@roles:salt-minion and G@roles:nginx':
    - selinux
    - nginx
  'G@roles:salt-minion and G@roles:elasticsearch':
    - selinux
    - elasticsearch.server
  'G@roles:salt-minion and G@roles:kibana':
    - selinux
    - kibana
