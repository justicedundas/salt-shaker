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
autostart: False
disposable: False
internal: False
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
{{ appvm_id(qconf.name) }}:
  qvm.vm:
    - name: {{ qconf.name }}
    - present:
      - template: {{ qconf.template }}
      - label: {{ qconf.label }}
{% if qconf.disposable %}
      - class: DispVM
{% endif %}
    - prefs:
      - template: {{ qconf.template }}
      - label: {{ qconf.label }}
{% if not qconf.network %}
      - netvm: ''
{% elif qconf.netvm is defined %}
      - netvm: {{ qconf.netvm }}
{% endif %}
{% if qconf.autostart %}
      - autostart: True
{% endif %}
{% if qconf.memory is defined %}
      - memory: {{ qconf.memory }}
{% endif %}
    - features:
      - enable:
{% if qconf.internal %}
        - internal
{% endif %}
      - disable:
{% if not qconf.internal %}
        - internal
{% endif %}
{% if qconf.tags is defined %}
    - tags:
      - add:
{% for tag in qconf.tags %}
        - {{ tag }}
{% endfor %}
{% endif %}
{% if requires %}
    - require:
{% for require in requires | list | unique %}
      - {{ require }}
{% endfor %}
{% endif %}
{% if qconf.volume | default(-1) > 0 %}
{{ appvm_id(qconf.name) }}-volume:
  cmd.run:
    - name: qvm-volume resize {{ qconf.name }}:private {{ qconf.volume }}
    - onlyif: test $(qvm-volume info {{ qconf.name }}:private size 2>/dev/null) -lt {{ qconf.volume }}
    - require:
      - qvm: {{ appvm_id(qconf.name) }}
{% endif %}
