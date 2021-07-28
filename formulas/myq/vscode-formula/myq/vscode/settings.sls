# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

vscode-settings:
  file.managed:
    - name: /home/user/.config/Code/User/settings.json
    - source: salt://myq/vscode/files/settings.json.j2
    - template: jinja
    - user: user
    - group: user
    - mode: 644
