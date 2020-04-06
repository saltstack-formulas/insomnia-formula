# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os == 'Windows' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import insomnia as insomnia with context %}
{%- from tplroot ~ "/macros.jinja" import format_kwargs with context %}

insomnia-package-binary-install:
  file.directory:
    - name: {{ insomnia.pkg.binary.name }}
    - user: {{ insomnia.rootuser }}
    - group: {{ insomnia.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: insomnia-package-binary-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(insomnia.pkg.binary) }}
    - retry: {{ insomnia.retry_option }}
    - user: {{ insomnia.rootuser }}
    - group: {{ insomnia.rootgroup }}
    - recurse:
        - user
        - group

    {%- else %}

insomnia-not-available-to-install:
  test.show_notification:
    - text: |
        The insomnia binary is only available on Windows

    {%- endif %}
