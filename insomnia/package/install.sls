# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import insomnia with context %}

    {%- if grains.os_family == 'Debian' and insomnia.pkg.use_upstream_repo %}

include:
  - .repo

insomnia-package-install-pkg-installed:
  pkg.installed:
    - name: {{ insomnia.pkg.name }}
    - refresh: true
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

insomnia-package-install-cmd-run-cask:
  cmd.run:
    - name: brew cask install insomnia
    - runas: {{ insomnia.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

insomnia-package-install-cmd-run-snap:
  pkg.installed:
    - names: {{ insomnia.pkg.deps|json }}
    - refresh: true
    - reload_modules: true
    - onlyif: {{ insomnia.pkg.deps|length > 0 }}
  service.running:
    - name: snapd
  cmd.run:
    - names:
      - sleep 20  # https://askubuntu.com/questions/1114117/ubuntu-18-04-lts-too-early-for-operation-error
      - snap install insomnia
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap
    - retry: {{ insomnia.retry_option }}
    - hide_output: true

    {%- endif %}
