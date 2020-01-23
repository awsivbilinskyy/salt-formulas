deploy_app:
  salt.state:
    - tgt: '*'
    - highstate: True