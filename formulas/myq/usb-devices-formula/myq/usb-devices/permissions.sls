# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set vmname = salt['grains.get']('nodename') %}
{% set udevrulesfile = "/rw/config/51-usb-devices.rules" %}

include:
  - myq.vm-startup.startup-script

usb-devices-rc-local:
  file.blockreplace:
    - name: /rw/config/rc.local
    - source: salt://myq/usb-devices/files/rc.local.block.sh.j2
    - template: jinja
    - context:
        vmname: {{ vmname }}
        udevrulesfile: {{ udevrulesfile }}
    - marker_start: '#### block-start - usb-devices - managed - do not update manually'
    - marker_end: '#### block-stop - usb-devices'
    - append_if_not_found: True
    - backup: False
    - require:
      - file: vm-startup-rc-local-init
      - file: usb-devices-udev-rules

usb-devices-udev-rules:
  file.managed:
    - name: {{ udevrulesfile }}
    - source: salt://myq/usb-devices/files/udev-rules.permissions.sh.j2
    - template: jinja
    - context:
        devices: {{ salt['pillar.get']('usb-devices', []) }}
    - user: root
    - group: root
    - mode: 755
