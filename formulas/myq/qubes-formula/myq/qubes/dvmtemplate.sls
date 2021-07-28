# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

{% from 'myq/qubes/macros.j2' import appvm_id with context %}
{% from 'myq/qubes/macros.j2' import template_id with context %}
{% set qcontext = {} %}
{% include 'myq/qubes/load_context.j2' with context %}
{% load_yaml as qconf %}
domain: {{ qcontext.domain }}
name: {{ qcontext.name }}
template: {{ qcontext.defaults.domain.template }}
label: {{ qcontext.defaults.domain.label }}
network: True
internal: False
appmenus: False
{% endload %}
{% if conf is defined %}
{% do qconf.update(conf) %}
{% endif %}
{% set includes = [] %}
{% set requires = [] %}
{% set rpm_template = salt['cmd.run']('qvm-prefs ' ~ qconf.template ~ ' installed_by_rpm') | to_bool %}
{% if not rpm_template %}
{% do includes.append('myq.' ~ qconf.domain ~ '.' ~ qconf.template) %}
{% do requires.append('qvm: ' ~ template_id(qconf.template)) %}
{% endif %}
{% if includes %}
include:
{% for include in includes | list | unique %}
  - {{ include }}
{% endfor %}
{% endif %}
{{ template_id(qconf.name) }}:
  qvm.vm:
    - name: {{ qconf.name }}
    - present:
      - template: {{ qconf.template }}
      - label: {{ qconf.label }}
    - prefs:
      - template: {{ qconf.template }}
      - label: {{ qconf.label }}
      - template-for-dispvms: True
      - default-dispvm: {{ qconf.name }}
{% if not qconf.network %}
      - netvm: ''
{% elif qconf.netvm is defined %}
      - netvm: {{ qconf.netvm }}
{% endif %}
    - features:
      - enable:
{% if qconf.appmenus %}
        - appmenus-dispvm
{% endif %}
{% if qconf.internal %}
        - internal
{% endif %}
      - disable:
{% if not qconf.internal %}
        - internal
{% endif %}
{% if requires %}
    - require:
{% for require in requires | list | unique %}
      - {{ require }}
{% endfor %}
{% endif %}
