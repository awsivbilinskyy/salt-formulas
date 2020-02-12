base:
  'roles:nginx':
    - match: grain
    - logstash_nginx

  'roles:elasticsearch':
    - match: grain
    - logstash_elastic

### minion highstates verificator   
  'roles:salt-minion':
    - match: grain
    - schedule