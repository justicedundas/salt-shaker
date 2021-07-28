# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set gui_user = salt['cmd.shell']('groupmems -l -g qubes') %}

{% for s in salt['pillar.get']('keyboard:shortcuts', []) | list if s.action == 'unset' %}
ui-config-keyboard-shortcut-unset-{{ s.shortcut | uuid }}:
  cmd.run:
    - name: xfconf-query --channel 'xfce4-keyboard-shortcuts' --property '{{ s.shortcut }}' --reset'
    - runas: {{ gui_user }}
    - onlyif: xfconf-query --channel 'xfce4-keyboard-shortcuts' --property '{{ s.shortcut }}' 2>/dev/null
{% endfor %}
{% for s in salt['pillar.get']('keyboard:shortcuts', []) | list if s.action == 'set' %}
ui-config-keyboard-shortcut-set-{{ s.shortcut | uuid }}:
  cmd.run:
    - name: xfconf-query --channel "xfce4-keyboard-shortcuts" --property "{{ s.shortcut }}" --create --type string --set "{{ s.value }}"
    - runas: {{ gui_user }}
    - unless: "[[ \"$(xfconf-query --channel 'xfce4-keyboard-shortcuts' --property '{{ s.shortcut }}' 2>/dev/null)\" == \"{{ s.value }}\" ]]"
{% endfor %}
