# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

vm-startup-rc-local-init:
  file.managed:
    - name: /rw/config/rc.local
    - source: salt://myq/vm-startup/files/rc.local.sh.j2
    - template: jinja
    - user: root
    - group: root
    - replace: {{ salt['pillar.get']('rc-local:clean', False)}}
    - mode: 755
