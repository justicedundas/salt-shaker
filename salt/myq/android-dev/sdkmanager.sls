# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

android-sdk-folder:
  file.directory:
    - name: /usr/local/android-sdk/cmdline-tools
    - makedirs: True

android-sdk-install:
  archive.extracted:
    - name: /usr/local/android-sdk/cmdline-tools
    - source: https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
    - source_hash: 89f308315e041c93a37a79e0627c47f21d5c5edbe5e80ea8dc0aac8a649e0e92
    - keep_source: False
    - clean: True
    - use_cmd_unzip: True
    - if_missing: /usr/local/android-sdk/cmdline-tools/latest
    - trim_output: 5
    - require:
      - file: android-sdk-folder

android-sdk-cmdline-tools:
  file.rename:
    - name: /usr/local/android-sdk/cmdline-tools/latest
    - source: /usr/local/android-sdk/cmdline-tools/tools
    - force: True
    - require:
      - archive: android-sdk-install

android-sdk-cmdline-tools-sdkmanager:
  file.symlink:
    - name: /usr/local/bin/sdkmanager
    - target: /usr/local/android-sdk/cmdline-tools/latest/bin/sdkmanager
    - force: True
    - require:
      - file: android-sdk-cmdline-tools

android-sdk-licenses:
  cmd.run:
# Fails with "yes: standard output: Broken pipe" if 'yes' error output is not redirected to '/dev/null'
# See https://stackoverflow.com/questions/20573282/hudson-yes-standard-output-broken-pipe for more details
    - name: yes 2> /dev/null | sdkmanager --licenses > /dev/null
    - unless: ls /usr/local/android-sdk/licenses
    - require:
      - file: android-sdk-cmdline-tools-sdkmanager
