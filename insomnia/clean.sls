# -*- coding: utf-8 -*-
# vim: ft=sls

             {%- if grains.os_family in ('MacOS',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import insomnia with context %}

include:
  -{{ ' .macapp.clean' if insomnia.pkg.use_upstream_macapp else ' .package.clean' }}

             {%- elif grains.os_family == 'Windows' %}
include:
  - .binary.clean

             {%- else %}
include:
  - .package.clean

             {%- endif %}
