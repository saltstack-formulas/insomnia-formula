# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import insomnia with context %}

insomnia-macos-app-install-curl:
  file.directory:
    - name: {{ insomnia.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ insomnia.dir.tmp }}/insomnia-{{ insomnia.version }} {{ insomnia.pkg.macapp.source }}
    - unless: test -f {{ insomnia.dir.tmp }}/insomnia-{{ insomnia.version }}
    - require:
      - file: insomnia-macos-app-install-curl
      - pkg: insomnia-macos-app-install-curl
    - retry: {{ insomnia.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
insomnia-macos-app-install-checksum:
  module.run:
    - onlyif: {{ insomnia.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ insomnia.dir.tmp }}/insomnia-{{ insomnia.version }}
    - file_hash: {{ insomnia.pkg.macapp.source_hash }}
    - require:
      - cmd: insomnia-macos-app-install-curl
    - require_in:
      - macpackage: insomnia-macos-app-install-macpackage
  file.absent:
    - name: {{ insomnia.dir.tmp }}/insomnia-{{ insomnia.version }}
    - onfail:
      - module: insomnia-macos-app-install-checksum

insomnia-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ insomnia.dir.tmp }}/insomnia-{{ insomnia.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: insomnia-macos-app-install-curl
  file.append:
    - name: '/Users/{{ insomnia.rootuser }}/.bash_profile'
    - text: 'export PATH=$PATH:/Applications/Insomnia.app/Contents/MacOS/Insomnia'
    - require:
      - macpackage: insomnia-macos-app-install-macpackage

    {%- else %}

insomnia-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The insomnia macpackagge is only available on MacOS

    {%- endif %}
