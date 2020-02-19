logstash:
  file_collection_logs:
  - /var/www/html/bastion/log/access.log
  - /var/www/html/bastion/log/error.log
{% if grains['os_family'] == 'Debian' %} 
  - /var/log/syslog
  - /var/log/auth.log
{% endif %}
{% if grains['os_family'] == 'RedHat' %} 
  - /var/log/messages
  - /var/log/lastlog
{% endif %}
  applied_filters:
  - apache2
  - syslog