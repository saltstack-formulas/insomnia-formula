# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import insomnia with context %}

insomnia-macos-app-clean-files:
  file.absent:
    - names:
      - {{ insomnia.dir.tmp }}
      - /Applications/Insomnia.app

    {%- else %}

insomnia-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The insomnia macpackage is only available on MacOS }}

    {%- endif %}
