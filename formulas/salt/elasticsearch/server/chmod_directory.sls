{%- from "elasticsearch/map.jinja" import server with context %}
/usr/share/elasticsearch:
  file.directory:
    - name: /usr/share/elasticsearch
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode

/var/log/elasticsearch:
  file.directory:
    - name: /var/log/elasticsearch
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode

/var/lib/elasticsearch:
  file.directory:
    - name: /var/lib/elasticsearch
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode

/etc/default/elasticsearch:
  file.directory:
    - name: /etc/default/elasticsearch
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode

/etc/elasticsearch:
  file.directory:
    - name: /etc/elasticsearch
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode
