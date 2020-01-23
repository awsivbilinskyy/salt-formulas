base:
  'salt':
    - selinux.selinux
  'minion* or G@os:Ubuntu':
    - selinux
    - nginx
  'minion* or G@os:CentOS':
    - selinux
    - nginx