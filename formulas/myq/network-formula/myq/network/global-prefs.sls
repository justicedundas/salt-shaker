# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set netvm = salt['cmd.shell']('qvm-ls --tags netvm --raw-list') %}
{% set fwvm = salt['cmd.shell']('qvm-ls --tags fwvm --raw-list') %}

{% if netvm | length %}
network-clockvm:
  cmd.run:
    - name: qubes-prefs clockvm {{ netvm }}
    - unless: "[[ \"$(qubes-prefs clockvm 2>/dev/null)\" == \"{{ netvm }}\" ]]"
{% endif %}

{% if fwvm | length %}
network-default-netvm:
  cmd.run:
    - name: qubes-prefs default_netvm {{ fwvm }}
    - unless: "[[ \"$(qubes-prefs default_netvm 2>/dev/null)\" == \"{{ fwvm }}\" ]]"

network-updatevm:
  cmd.run:
    - name: qubes-prefs updatevm {{ fwvm }}
    - unless: "[[ \"$(qubes-prefs updatevm 2>/dev/null)\" == \"{{ fwvm }}\" ]]"
{% endif %}
