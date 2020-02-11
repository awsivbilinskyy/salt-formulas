logstash-nginx:
  file_collection_logs:
  - /var/log/nginx/access.log
  - /var/log/nginx/error.log
  - /var/log/syslog
  - /var/log/auth.log
  applied_filters:
  - nginx
  - syslog