base:
  'salt':
    - selinux.xelinux
  'minion* or G@os:Ubuntu':
    - selinux
    - nginx
  'minion* or G@os:CentOS':
    - selinux
    - nginx