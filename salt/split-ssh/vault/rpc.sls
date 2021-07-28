# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/rw/config/split-ssh/qubes.SSHAgent:
  file.managed:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - source: salt://split-ssh/vault/files/qubes.SSHAgent

rpc-present:
   file.append:
    - name: /rw/config/rc.local
    - source: salt://split-ssh/vault/files/rc.local.d/rpc
