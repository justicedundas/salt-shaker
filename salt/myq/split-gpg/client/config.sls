# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/rw/config/gpg-split-domain:
  file.managed:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - source: salt://split-gpg/client/files/gpg-split-domain.jinja
    - template: jinja
