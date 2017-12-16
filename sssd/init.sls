{# sssd #}

{## import settings from map.jinja ##}
{% from "sssd/map.jinja" import sssd_settings with context %}

sssd:
  pkg.installed:
    - pkgs: {{ sssd_settings.lookup.pkgs }}

{% if sssd_settings.config.manage == True %}
{{ sssd_settings.lookup.locations.config_file }}:
  file.managed:
    - user: {{ sssd_settings.lookup.user }}
    - group: {{ sssd_settings.lookup.group }}
    - mode: 640
    - source: salt://sssd/files/sssd.conf
    - template: jinja
    - context:
      config: {{ sssd_settings.config.options }}
    - require:
      - pkg: sssd

{% if 'ca_certificates' in sssd_settings.config %}
{{ sssd_settings.lookup.locations.ca_certs_dir }}:
  file.directory:
    - makedirs: True
    - user: {{ sssd_settings.lookup.user }}
    - group: {{ sssd_settings.lookup.group }}
    - mode: 0750
    - require:
      - pkg: sssd

{{ sssd_settings.lookup.locations.ca_certs_dir }}/ca-certificates.crt:
  file.managed:
    - contents_pillar: sssd:config:ca_certificates
    - user: {{ sssd_settings.lookup.user }}
    - group: {{ sssd_settings.lookup.group }}
    - mode: 0640
    - require:
      - file: {{ sssd_settings.lookup.locations.ca_certs_dir }}
{% endif %}
{% endif %}

{% if sssd_settings.service.manage == True %}
service-sssd:
  service.running:
    - name: {{ sssd_settings.lookup.service }}
    - enable: True
    - require:
      - pkg: sssd
      - file: {{ sssd_settings.lookup.locations.config_file }}
    - watch:
      - pkg: sssd
      - file: {{ sssd_settings.lookup.locations.config_file }}
{% endif %}

{# EOF #}
