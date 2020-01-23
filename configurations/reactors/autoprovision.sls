install_nginx:
  local.state.single:
    - tgt: 'roles:webserver'
      - tgt_type: grain
    - arg:
      - pkg.installed
        - nginx
