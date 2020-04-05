# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import insomnia with context %}

insomnia-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ insomnia.pkg.repo.name }}
    - onlyif: {{ insomnia.pkg.repo and insomnia.pkg.use_upstream_repo }}
