# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

include:
  - myq.android-dev.sdkmanager

{% if pillar['android-dev']['emulators'] is defined %}
android-sdk-cmdline-tools-avdmanager:
  file.symlink:
    - name: /usr/local/bin/avdmanager
    - target: /usr/local/android-sdk/cmdline-tools/latest/bin/avdmanager
    - force: True
    - require:
      - file: android-sdk-cmdline-tools

android-sdk-emulator:
  cmd.run:
    - name: sdkmanager "emulator" > /dev/null
    - require:
      - cmd: android-sdk-licenses

{% for tool in salt['pillar.get']('android-dev:emulators:tools', []) %}
android-sdk-emulator-link-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /usr/local/android-sdk/emulator/{{ tool }}
    - force: True
    - require:
      - cmd: android-sdk-emulator
{% endfor %}

{% for platform, images in salt['pillar.get']('android-dev:emulators:platforms', {}).items() %}
android-sdk-platform-{{ platform }}:
  cmd.run:
    - name: sdkmanager "platforms;{{ platform }}" > /dev/null
    - require:
      - file: android-sdk-cmdline-tools-avdmanager

{% for image in images | default([]) %}
android-sdk-system-image-{{ image }}:
  cmd.run:
    - name: sdkmanager "{{ image }}" > /dev/null
    - require:
      - file: android-sdk-cmdline-tools-avdmanager
      - cmd: android-sdk-platform-{{ platform }}
{% endfor %}
{% endfor %}
{% endif %}
