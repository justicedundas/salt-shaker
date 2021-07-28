# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

## Load config
#{% load_yaml as config %}
#{% include 'split-gpg/config.yaml' %}
#{% endload %}
---
split-gpg-vaults:
  {{ config.vaults }}
