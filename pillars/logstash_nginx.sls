logstash-nginx:
  file_collection_logs:
  - /var/log/nginx/access.log
  - /var/log/nginx/error.log
  applied_filters:
  - nginx
  - syslog