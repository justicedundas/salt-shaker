# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set desktop_files = [] %}

{% set gui_user = salt['cmd.shell']('groupmems -l -g qubes') %}
{% set home_folder = salt['user.info'](gui_user).home %}

{% set netvm = salt['cmd.shell']('qvm-ls --tags netvm --raw-list') %}

{% if netvm | length %}

{% for pname, profile in pillar['network-profiles'].items() %}
{% set desktop_file = home_folder ~ "/.local/share/applications/network-profile-" ~ pname ~ ".desktop" %}
{% do desktop_files.append(desktop_file) %}

network-profiles-qubes-rpc-{{ pname }}:
  file.managed:
    - name: /etc/qubes-rpc/network.profile.{{ pname | capitalize }}
    - source: salt://myq/network/files/qubes-rpc.network-profile-set.sh.j2
    - template: jinja
    - context:
        netvm: {{ netvm }}
        profile: {{ pname }}
        profilename: {{ profile.name }}
        wifi: {{ profile.wifi }}
    - user: root
    - group: root
    - mode: 755

network-profiles-qubes-rpc-{{ pname }}-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/network.profile.{{ pname }}
    - source: salt://myq/network/files/qubes-rpc-policy.network-profile.sh.j2
    - template: jinja
    - context:
        netvm: {{ netvm }}
    - user: root
    - group: qubes
    - mode: 664
    - require:
      - file: network-profiles-qubes-rpc-{{ pname }}

network-profiles-menu-{{ pname }}:
  file.managed:
    - name: {{ desktop_file }}
    - source: salt://myq/network/files/desktop-file.j2
    - template: jinja
    - context:
        name: "profile: {{ profile.name}}"
        comment: "Apply {{ profile.name}} network profile"
        icon: network-receive
        exec: /etc/qubes-rpc/network.profile.{{ pname | capitalize }}
    - onchanges_in:
      - cmd: network-profiles-menu-install

{% endfor %}

network-profiles-qubes-rpc-clean:
  file.managed:
    - name: /etc/qubes-rpc/network.profile.Clean
    - source: salt://myq/network/files/qubes-rpc.network-profile-clean.sh.j2
    - template: jinja
    - context:
        netvm: {{ netvm }}
    - user: root
    - group: root
    - mode: 755

network-profiles-qubes-rpc-clean-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/network.profile.Clean
    - source: salt://myq/network/files/qubes-rpc-policy.network-profile.sh.j2
    - template: jinja
    - context:
        netvm: {{ netvm }}
    - user: root
    - group: qubes
    - mode: 664
    - require:
      - file: network-profiles-qubes-rpc-clean

{% set desktop_file = home_folder ~ "/.local/share/applications/network-profile-clean.desktop" %}
{% do desktop_files.append(desktop_file) %}

network-profiles-menu-clean:
  file.managed:
    - name: {{ desktop_file }}
    - source: salt://myq/network/files/desktop-file.j2
    - template: jinja
    - context:
        name: "Clean profiles"
        comment: "Clean network profile"
        icon: network-error
        exec: /etc/qubes-rpc/network.profile.Clean
    - onchanges_in:
      - cmd: network-profiles-menu-install

{% set directory_file = home_folder ~ "/.local/share/desktop-directories/network-profile.directory" %}
network-profiles-menu-directory:
  file.managed:
    - name: {{ directory_file }}
    - source: salt://myq/network/files/directory-file.j2
    - template: jinja
    - context:
        name: "Configure Network Profiles"
        icon: network-wired-symbolic
    - onchanges_in:
      - cmd: network-profiles-menu-install

network-profiles-menu-install:
  cmd.run:
    - name: xdg-desktop-menu install {{ directory_file }} {{ desktop_files | join(' ') }}

{% endif %}
