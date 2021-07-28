# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

ssh-socket-present:
   file.append:
    - name: /rw/config/rc.local
    - source: salt://split-ssh/client/files/rc.local.d/sock.jinja
    - template: jinja

ssh-socket-discoverable:
   file.append:
    - name: ~user/.bashrc
    - source: salt://split-ssh/client/files/bashrc.d/sock.jinja
    - template: jinja
