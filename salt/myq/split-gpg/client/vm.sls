# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% for client in pillar.get('split-gpg-clients') %}
{{ client.name }}-present:
  qvm.present:
    - name: {{ client.name }}
    - template: {{ client.template }}
    - label: {{ client.label }}
    - mem: {{ client.mem }}
    - vcpus: {{ client.vcpus }}

{{ client.name }}-autostarts:
  qvm.prefs:
    - name: {{ client.name }}
    - autostart: {{ client.autostart }}
{% endfor %}

