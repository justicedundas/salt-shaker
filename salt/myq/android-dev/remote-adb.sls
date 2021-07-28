# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% set usbvm = salt['cmd.shell']('qvm-ls --tags usbvm --raw-list') %}

{% if usbvm | length %}
android-dev-qubes-rpc-remote-adb-start:
  file.managed:
    - name: /etc/qubes-rpc/android.dev.StartRemoteADB
    - source: salt://myq/android-dev/files/qubes-rpc.remote-adb-start.sh.j2
    - template: jinja
    - context:
        usbvm: {{ usbvm }}
    - user: root
    - group: root
    - mode: 755

android-dev-qubes-rpc-remote-adb-start-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/android.dev.StartRemoteADB
    - source: salt://myq/android-dev/files/qubes-rpc-policy.remote-adb.sh.j2
    - template: jinja
    - user: root
    - group: qubes
    - mode: 664

android-dev-qubes-rpc-remote-adb-stop:
  file.managed:
    - name: /etc/qubes-rpc/android.dev.StopRemoteADB
    - source: salt://myq/android-dev/files/qubes-rpc.remote-adb-stop.sh.j2
    - template: jinja
    - context:
        usbvm: {{ usbvm }}
    - user: root
    - group: root
    - mode: 755

android-dev-qubes-rpc-remote-adb-stop-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/android.dev.StopRemoteADB
    - source: salt://myq/android-dev/files/qubes-rpc-policy.remote-adb.sh.j2
    - template: jinja
    - user: root
    - group: qubes
    - mode: 664

{% set androidvms = salt['cmd.shell']('qvm-ls --tags android --raw-list') %}
{% if androidvms | length %}
{% for androidvm in androidvms.split('\n') | list | default([]) %}
{{ androidvm }}-adb-connect:
  file.accumulated:
    - name: tcp_connections
    - filename: /etc/qubes-rpc/policy/qubes.ConnectTCP
    - text: '{{ androidvm }} @default allow,target={{ usbvm }}'
    - require_in:
      - file: qubesrpc-tcp-connect

{{ androidvm }}-remote-adb-start-policy:
  file.accumulated:
    - name: remote_adb_policy_sources
    - filename: /etc/qubes-rpc/policy/android.dev.StartRemoteADB
    - text: '{{ androidvm }}'
    - require_in:
      - file: android-dev-qubes-rpc-remote-adb-start-policy

{{ androidvm }}-remote-adb-stop-policy:
  file.accumulated:
    - name: remote_adb_policy_sources
    - filename: /etc/qubes-rpc/policy/android.dev.StopRemoteADB
    - text: '{{ androidvm }}'
    - require_in:
      - file: android-dev-qubes-rpc-remote-adb-stop-policy
{% endfor %}
{% endif %}

{% endif %}
