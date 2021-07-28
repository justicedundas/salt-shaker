# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% for name, value in salt['pillar.get']('git:config',{}).items() %}
git-config-{{ name }}:
  git.config_set:
    - name: {{ name }}
    - value: {{ value }}
    - user: user
    - global: True
{% endfor %}
