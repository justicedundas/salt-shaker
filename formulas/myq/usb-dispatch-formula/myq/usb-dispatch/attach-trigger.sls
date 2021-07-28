# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set udevrulesfolder = "/rw/config/udev-usb-dispatch" %}

include:
  - myq.vm-startup.startup-script

usb-attach-udev-folder:
  file.directory:
    - name: {{ udevrulesfolder }}
    - makedirs: True
    - user: root
    - group: root
    - mode: 755

{% for vmname, devices in salt['pillar.get']('usb-dispatch', {}).items() %}
usb-attach-udev-rules-attach-trigger-{{ vmname }}:
  file.managed:
    - name: {{ udevrulesfolder }}/52-usb-attach-{{ vmname }}.rules
    - source: salt://myq/usb-dispatch/files/udev-rules.attach-trigger.sh.j2
    - template: jinja
    - context:
        vmname: {{ vmname }}
        devices: {{ devices }}
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: usb-attach-udev-folder
    - require_in:
      - file: usb-attach-rc-local
{% endfor %}

usb-attach-rc-local:
  file.blockreplace:
    - name: /rw/config/rc.local
    - source: salt://myq/usb-dispatch/files/rc.local.block.sh.j2
    - template: jinja
    - context:
        udevrulesfolder: {{ udevrulesfolder }}
    - marker_start: '#### block-start - usb-dispatch - managed - do not update manually'
    - marker_end: '#### block-stop - usb-dispatch'
    - append_if_not_found: True
    - backup: False
    - require:
      - file: vm-startup-rc-local-init
