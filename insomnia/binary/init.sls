#.-*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os == 'Windows' %}

include:
  - .install

    {%- else %}

insomnia-not-available-to-init:
  test.show_notification:
    - text: |
        The insomnia archive is only available on Windows

    {%- endif %}
