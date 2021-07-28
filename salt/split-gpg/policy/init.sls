# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

gpg-vault-policy-present:
  file.prepend:
    - name: /etc/qubes-rpc/policy/qubes.Gpg
    - source: salt://split-gpg/policy/files/qubes.Gpg.d/vault.jinja
    - template: jinja
