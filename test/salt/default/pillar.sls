# -*- coding: utf-8 -*-
# vim: ft=yaml
---
insomnia:
  version: 7.1.1    # windows and macpackage
  pkg:
    # Linux (except Debian) uses snap
    use_upstream_repo: false    # Debian
    use_upstream_archive: false  # win
    use_upstream_macapp: true   # macos
    macapp:
      uri: https://updates.insomnia.rest/downloads/mac
      source_hash: 7718dd2c1a6ec0edafe36116d9123cda80b769abadc2d4fc5c5389922c7dfa6f
