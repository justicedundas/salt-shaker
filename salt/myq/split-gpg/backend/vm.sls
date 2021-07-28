# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% for backend in pillar.get('split-gpg-backends') %}
{{ backend.name }}-present:
  qvm.present:
    - name: {{ backend.name }}
    - template: {{ backend.template }}
    - label: {{ backend.label }}
    - mem: {{ backend.mem }}
    - vcpus: {{ backend.vcpus }}

{{ backend.name }}-has-no-network-access:
  qvm.prefs:
    - name: {{ backend.name }}
    - netvm: none
    - default_dispvm:

{{ backend.name }}-autostarts:
  qvm.prefs:
    - name: {{ backend.name }}
    - autostart: {{ backend.autostart }}
{% endfor %}
