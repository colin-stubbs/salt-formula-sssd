{# sssd.authconfig #}

{## import settings from map.jinja ##}
{% from "sssd/map.jinja" import sssd_settings with context %}

include:
  - sssd

authconfig:
  pkg:
    - installed

authconfig_updateall:
  cmd.run:
    - name: authconfig {{ sssd_settings.authconfig.updateall_args }} --updateall
    - unless: test "`authconfig {{ sssd_settings.authconfig.updateall_args }} --updateall --test`" = "`authconfig --test`"
    - require:
      - pkg: authconfig

{# EOF #}
