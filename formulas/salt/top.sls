base:
  'G@roles:salt-master':
    - selinux.selinux
    - logstash
  'G@roles:salt-minion and G@roles:nginx':
    - selinux
    - nginx
    - logstash
  'G@roles:salt-minion and G@roles:elasticsearch':
    - selinux
    - elasticsearch.server
    - kibana
    - logstash
  'G@roles:salt-minion and G@roles:bastion':
    - apache2bastion
