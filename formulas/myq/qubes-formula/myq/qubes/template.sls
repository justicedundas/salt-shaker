# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% from 'myq/qubes/macros.j2' import template_id with context %}
{% set qcontext = {} %}
{% include 'myq/qubes/load_context.j2' with context %}
{% load_yaml as qconf %}
domain: {{ qcontext.domain }}
name: {{ qcontext.name }}
label: {{ qcontext.defaults.template.label }}
{% endload %}
{% if conf is defined %}
{% do qconf.update(conf) %}
{% endif %}
{{ template_id(qconf.name) }}:
  qvm.vm:
    - name: {{ qconf.name }}
    - clone:
      - source: {{ qconf.source }}
      - label: {{ qconf.label }}
    - prefs:
      - label: {{ qconf.label }}
