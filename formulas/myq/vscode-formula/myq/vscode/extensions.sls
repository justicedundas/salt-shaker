# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% for extension in salt['pillar.get']('vscode:extensions', []) %}
vscode-ext-{{ extension | lower }}:
  cmd.run:
    - name: code --install-extension {{ extension }} --force
    - runas: user
    - onlyif: which code
    - unless: "code --list-extensions | grep \"^{{ extension }}$\""
{% endfor %}
