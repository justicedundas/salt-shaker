# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

font-powerlevel10k-regular:
  file.managed:
    - name: /usr/share/fonts/meslolgsnf/MesloLGS NF Regular.ttf
    - source: salt://myq/zsh-terminal/fonts/MesloLGS NF Regular.ttf
    - user: user
    - group: user
    - mode: 644
    - makedirs: True
    - onchanges_in:
      - cmd: font-cache-reload

font-powerlevel10k-bold:
  file.managed:
    - name: /usr/share/fonts/meslolgsnf/MesloLGS NF Bold.ttf
    - source: salt://myq/zsh-terminal/fonts/MesloLGS NF Bold.ttf
    - user: user
    - group: user
    - mode: 644
    - makedirs: True
    - onchanges_in:
      - cmd: font-cache-reload

font-powerlevel10k-italic:
  file.managed:
    - name: /usr/share/fonts/meslolgsnf/MesloLGS NF Italic.ttf
    - source: salt://myq/zsh-terminal/fonts/MesloLGS NF Italic.ttf
    - user: user
    - group: user
    - mode: 644
    - makedirs: True
    - onchanges_in:
      - cmd: font-cache-reload

font-powerlevel10k-bolditalic:
  file.managed:
    - name: /usr/share/fonts/meslolgsnf/MesloLGS NF Bold Italic.ttf
    - source: salt://myq/zsh-terminal/fonts/MesloLGS NF Bold Italic.ttf
    - user: user
    - group: user
    - mode: 644
    - makedirs: True
    - onchanges_in:
      - cmd: font-cache-reload

font-cache-reload:
  cmd.run:
    - name: fc-cache -v
    - runas: user
