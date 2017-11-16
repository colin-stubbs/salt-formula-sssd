{# sssd.authconfig #}

{## import settings from map.jinja ##}
{% from "sssd/map.jinja" import sssd_settings with context %}

include:
  - sssd

sssd-sysauth-req-authconfig:
  pkg.installed:
    - name: authconfig

authconfig_updateall:
  cmd.run:
    - name: authconfig {{ sssd_settings.authconfig.updateall_args }} --updateall
    - unless: test "`authconfig {{ sssd_settings.authconfig.updateall_args }} --updateall --test`" = "`authconfig --test`"
    - require:
      - pkg: sssd-sysauth-req-authconfig
{% if sssd_settings.service.manage == True %}
      - service: service-sssd
{% endif %}

{# EOF #}
