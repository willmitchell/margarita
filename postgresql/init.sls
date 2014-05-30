include:
  - locale.utf8

db-packages:
  pkg:
    - installed
    - names:
      - postgresql-contrib-9.3
      - postgresql-server-dev-9.3
      - postgresql-client-9.3
      - libpq-dev
      - postgresql-9.3-postgis-2.1

postgresql:
  pkg:
    - installed
  service:
    - running
    - enable: True

/var/lib/postgresql/configure_utf-8.sh:
  cmd.wait:
    - name: bash /var/lib/postgresql/configure_utf-8.sh
    - user: postgres
    - cwd: /var/lib/postgresql
    - unless: psql -U postgres template1 -c 'SHOW SERVER_ENCODING' | grep "UTF8"
    - require:
      - file: /etc/default/locale
    - watch:
      - file: /var/lib/postgresql/configure_utf-8.sh

  file.managed:
    - name: /var/lib/postgresql/configure_utf-8.sh
    - source: salt://postgresql/default-locale.sh
    - user: postgres
    - group: postgres
    - mode: 755
    - require:
      - pkg: postgresql
