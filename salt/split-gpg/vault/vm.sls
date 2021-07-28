# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% for vault in pillar.get('split-gpg-vaults') %}
{{ vault.name }}-present:
  qvm.present:
    - name: {{ vault.name }}
    - template: {{ vault.template }}
    - label: {{ vault.label }}
    - mem: {{ vault.mem }}
    - vcpus: {{ vault.vcpus }}

{{ vault.name }}-has-no-network-access:
  qvm.prefs:
    - name: {{ vault.name }}
    - netvm: none
    - default_dispvm:

{{ vault.name }}-autostarts:
  qvm.prefs:
    - name: {{ vault.name }}
    - autostart: {{ vault.autostart }}
{% endfor %}
