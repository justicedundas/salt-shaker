# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set usbvm = salt['cmd.shell']('qvm-ls --tags usbvm --raw-list') %}

{% if usbvm | length %}

{% for vmname, devices in salt['pillar.get']('usb-dispatch', {}).items() %}
usb-dispatch-qubes-rpc-attach-{{ vmname }}:
  file.managed:
    - name: /etc/qubes-rpc/usb.{{ vmname }}.Attach
    - source: salt://myq/usb-dispatch/files/qubes-rpc.attach.sh.j2
    - template: jinja
    - context:
        vmname: {{ vmname }}
        devices: {{ devices }}
    - user: root
    - group: root
    - mode: 755

usb-dispatch-qubes-rpc-attach-{{ vmname }}-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/usb.{{ vmname }}.Attach
    - source: salt://myq/usb-dispatch/files/qubes-rpc-policy.attach.sh.j2
    - template: jinja
    - context:
        vmname: {{ vmname }}
        usbvm: {{ usbvm }}
    - user: root
    - group: qubes
    - mode: 664
    - require:
      - file: usb-dispatch-qubes-rpc-attach-{{ vmname }}
{% endfor %}

{% endif %}
