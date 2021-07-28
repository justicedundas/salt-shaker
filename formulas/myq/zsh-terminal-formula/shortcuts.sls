# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

gnome-terminal-shortcut-copy:
  cmd.run:
    - name: dconf write /org/gnome/terminal/legacy/keybindings/copy "'<Super>c'"
    - runas: user
    - unless: "[[ `dconf read /org/gnome/terminal/legacy/keybindings/copy` == \"'<Super>c'\" ]]"

gnome-terminal-shortcut-paste:
  cmd.run:
    - name: dconf write /org/gnome/terminal/legacy/keybindings/paste "'<Super>v'"
    - runas: user
    - unless: "[[ `dconf read /org/gnome/terminal/legacy/keybindings/paste` == \"'<Super>v'\" ]]"
