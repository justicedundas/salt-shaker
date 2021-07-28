# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

remote-adb-adbctl:
  file.managed:
    - name: /usr/local/bin/adbctl
    - source: salt://myq/android-dev/files/adbctl.sh.j2
    - user: root
    - group: root
    - mode: 755
