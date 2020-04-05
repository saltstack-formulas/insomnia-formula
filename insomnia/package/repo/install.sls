# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import insomnia with context %}
{%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

insomnia-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(insomnia.pkg.repo) }}
    - onlyif: {{ insomnia.pkg.repo and insomnia.pkg.use_upstream_repo }}
