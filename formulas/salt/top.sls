base:
  'G@roles:salt-master':
    - selinux.selinux
  'G@roles:salt-minion and G@roles:nginx':
    - selinux
    - nginx
  'G@roles:salt-minion and G@roles:elasticsearch':
    - selinux
    - elasticsearch.server
    - kibana
  'G@roles:salt-minion and G@roles:elasticclient':
    - selinux
    - elasticsearch.client
