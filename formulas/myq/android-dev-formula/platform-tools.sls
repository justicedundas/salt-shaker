# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

include:
  - myq.android-dev.sdkmanager

android-sdk-platform-tools:
  cmd.run:
    - name: sdkmanager "platform-tools" > /dev/null
    - require:
      - cmd: android-sdk-licenses

{% for tool in salt['pillar.get']('android-dev:platform-tools', []) %}
android-sdk-platform-tools-link-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /usr/local/android-sdk/platform-tools/{{ tool }}
    - force: True
    - require:
      - cmd: android-sdk-platform-tools
{% endfor %}
