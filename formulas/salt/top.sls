base:
  'salt':
    - selinux.selinux
  'minion* or G@os:Ubuntu':
    - selinux
    - nginx
    - nginx.restart
  'minion* or G@os:CentOS':
    - selinux
    - nginx
    - nginx.restart