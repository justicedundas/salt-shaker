# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/etc/qubes-rpc/policy/qubes.SSHAgent:
  file.managed:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - source: salt://split-ssh/policy/files/qubes.SSHAgent
    - template: jinja

