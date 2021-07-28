# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

# ZSH & prezto configuration

zsh-config-zlogin:
  file.symlink:
    - name: /home/user/.zlogin
    - target: /home/user/.zprezto/runcoms/zlogin
    - force: True
    - require:
      - git: zsh-config-repo

zsh-config-zlogout:
  file.symlink:
    - name: /home/user/.zlogout
    - target: /home/user/.zprezto/runcoms/zlogout
    - force: True
    - require:
      - git: zsh-config-repo

zsh-config-zpreztorc:
  file.symlink:
    - name: /home/user/.zpreztorc
    - target: /home/user/.zprezto/runcoms/zpreztorc
    - force: True
    - require:
      - git: zsh-config-repo

zsh-config-zprofile:
  file.symlink:
    - name: /home/user/.zprofile
    - target: /home/user/.zprezto/runcoms/zprofile
    - force: True
    - require:
      - git: zsh-config-repo

zsh-config-zshenv:
  file.symlink:
    - name: /home/user/.zshenv
    - target: /home/user/.zprezto/runcoms/zshenv
    - force: True
    - require:
      - git: zsh-config-repo

zsh-config-zshrc:
  file.symlink:
    - name: /home/user/.zshrc
    - target: /home/user/.zprezto/runcoms/zshrc
    - force: True
    - require:
      - git: zsh-config-repo

# Prowerlevel 10k configuration

zsh-config-prompt:
  file.symlink:
    - name: /home/user/.p10k.zsh
    - target: /home/user/.zprezto/runcoms/p10k.zsh
    - force: True
    - require:
      - git: zsh-config-repo

# tmux configuration (enabled at prezto startup)

zsh-config-tmux:
  file.symlink:
    - name: /home/user/.tmux.conf
    - target: /home/user/.zprezto/runcoms/tmux.conf
    - force: True
    - require:
      - git: zsh-config-repo
