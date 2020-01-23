instal_epel:
  local.pkg.install:
    - tgt: 'G@roles:webserver and G@os_family:RedHat'
    - args:
      - name: epel-release

install_nginx:
  local.pkg.install:
    - tgt: 'G@roles:webserver'
    - args:
      - name: nginx