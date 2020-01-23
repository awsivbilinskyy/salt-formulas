{% if data['id'] == 'minion*' %}
highstate_run:
  local.state.apply:
    - tgt: minion*
{% endif %}
