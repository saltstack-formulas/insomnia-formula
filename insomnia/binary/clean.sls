# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os == 'Windows' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import insomnia with context %}

insomnia-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ insomnia.pkg.archive.name }}

    {%- else %}

insomnia-not-available-to-clean:
  test.show_notification:
    - text: |
        The insomnia archive is only available on Windows

    {%- endif %}
