# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os == 'Windows' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import insomnia as insomnia with context %}
{%- from tplroot ~ "/macros.jinja" import format_kwargs with context %}

insomnia-package-archive-install:
  file.directory:
    - name: {{ insomnia.pkg.archive.name }}
    - user: {{ insomnia.rootuser }}
    - group: {{ insomnia.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: insomnia-package-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(insomnia.pkg.archive) }}
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
        The insomnia archive is only available on Windows

    {%- endif %}
