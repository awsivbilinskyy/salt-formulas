restore_rh_mysql_server_config:
  local.state.single:
    - tgt: 'E@autominion* and G@os_family:RedHat'
    - tgt_type: compound
    - args:
      - fun: file.managed
      - name: /etc/my.cnf.d/server.cnf
      - source: salt://salt-formulas/files/rh_server.cnf
