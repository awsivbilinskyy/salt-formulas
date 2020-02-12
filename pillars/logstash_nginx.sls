logstash:
  file_collection_logs:
  - /var/log/nginx/access.log
  - /var/log/nginx/error.log
{% if grains['os_family'] == 'Debian' %} 
  - /var/log/syslog
  - /var/log/auth.log
{% endif %}
{% if grains['os_family'] == 'RedHat' %} 
  - /var/log/messages
  - /var/log/lastlog
  collection_directory_list:
  - /var/log/nginx
{% endif %}
  applied_filters:
  - nginx
  - syslog

