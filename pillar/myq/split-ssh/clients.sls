# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

## Load config
#{% load_yaml as config %}
#{% include 'split-ssh/config.yaml' %}
#{% endload %}
---
split-ssh-clients:
  {{ config.clients }}
