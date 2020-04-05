# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import insomnia with context %}

    {%- if grains.os_family == 'Debian' and insomnia.pkg.use_upstream_repo %}

include:
  - .repo.clean

insomnia-package-remove-pkg-removed:
  pkg.removed:
    - name: {{ insomnia.pkg.name }}
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

insomnia-package-remove-cmd-run-cask:
  cmd.run:
    - name: brew cask remove insomnia
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

insomnia-package-remove-cmd-run-snap:
  cmd.run:
    - name: snap remove insomnia
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- endif %}
