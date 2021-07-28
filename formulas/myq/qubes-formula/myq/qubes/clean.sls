# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% for qube in qubes_to_clean %}
clean-{{ qube }}:
  qvm.absent:
    - name: {{ qube }}
{% endfor %}
