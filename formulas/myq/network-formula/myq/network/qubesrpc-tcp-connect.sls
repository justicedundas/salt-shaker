# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

qubesrpc-tcp-connect:
  file.managed:
    - name: /etc/qubes-rpc/policy/qubes.ConnectTCP
    - source: salt://myq/network/files/qubes-rpc-policy.tcp-connect.sh.j2
    - template: jinja
    - user: root
    - group: qubes
    - mode: 664
