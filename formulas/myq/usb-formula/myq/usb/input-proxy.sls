# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set usbvm = salt['cmd.shell']('qvm-ls --tags usbvm --raw-list') %}

{% if usbvm | length %}
usb-input-proxy:
  pkg.installed:
    - name: qubes-input-proxy

usb-input-proxy-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/qubes.InputMouse
    - source: salt://myq/usb/files/qubes-rpc-policy.input-mouse.j2
    - template: jinja
    - context:
        usbvm: {{ usbvm }}
    - user: root
    - group: root
    - mode: 664
    - require:
      - pkg: usb-input-proxy
{% endif %}
