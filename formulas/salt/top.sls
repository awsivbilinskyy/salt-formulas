base:
  'G@roles:salt-master':
    - selinux.selinux
  'G@roles:salt-minion* and G@roles:nginx':
    - selinux
    - nginx
  'G@roles:salt-minion* and G@roles:elasticsearch':
    - elasticsearch
