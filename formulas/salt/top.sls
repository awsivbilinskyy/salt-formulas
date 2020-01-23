base:
  'salt':
    - selinux.selinux
  'minion* or G@os:Ubuntu':
    - selinux
    - nginx
#    - nginx.service
  'minion* or G@os:CentOS':
    - selinux
    - nginx
#    - nginx.service