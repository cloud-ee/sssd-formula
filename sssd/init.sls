sssd:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: sssd
      - file: /etc/sssd/sssd.conf

dependencies:
  pkg.installed:
    - pkgs:
      - libnss-sss
      - libpam-sss

pam-auth-update --package:
  cmd.wait:
    - watch:
      - file: /usr/share/pam-configs/mkhomedir

/etc/sssd/sssd.conf:
  file.managed:
    - source: salt://sssd/files/sssd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 0600

/etc/nsswitch.conf:
  file.managed:
    - source: salt://sssd/files/nsswitch.conf
    - user: root
    - group: root
    - mode: 0644

/usr/share/pam-configs/mkhomedir:
  file.managed:
    - source: salt://sssd/files/mkhomedir
    - user: root
    - group: root
    - mode: 0644

