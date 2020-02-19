base:
  'roles:nginx':
    - match: grain
    - logstash_nginx

  'roles:elasticsearch':
    - match: grain
    - logstash_elastic

  'roles:bastion':
    - match: grain
    - logstash_bastion

### minion highstates verificator   
  'roles:salt-minion':
    - match: grain
    - schedule