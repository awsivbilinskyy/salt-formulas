base:
  'roles:nginx':
    - match: grain
    - logstash_nginx

  'roles:elasticsearch':
    - match: grain
    - logstash_elastic