# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os == 'Windows' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import insomnia with context %}

insomnia-package-binary-clean-file-absent:
  file.absent:
    - names:
      - {{ insomnia.pkg.binary.name }}

    {%- else %}

insomnia-not-available-to-clean:
  test.show_notification:
    - text: |
        The insomnia binary is only available on Windows

    {%- endif %}
