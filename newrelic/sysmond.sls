{% if ((grains['os_family'] == 'Debian') or
       (grains['os_family'] == 'RedHat' and
        grains['osmajorrelease'][0] in ['5', '6'])) %}
newrelic-sysmond:
{% if grains['os_family'] == 'Debian' %}
  pkgrepo.managed:
    - humanname: Newrelic PPA
    - name: deb http://apt.newrelic.com/debian/ newrelic non-free
    - file: /etc/apt/sources.list.d/newrelic.list
    - keyid: 548C16BF
    - keyserver: pgp.mit.edu
    - require_in:
      - pkg: newrelic-sysmond
{% elif grains['os_family'] == 'RedHat' %}
  pkg.installed:
    - name : newrelic-repo-5-3
    - sources:
    - newrelic: http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm
    - require_in:
      - pkg: newrelic-sysmond
{% endif %}
  pkg:
    - installed
  cmd.run:
    - name: nrsysmond-config --set license_key={{ pillar['newrelic']['license_key'] }}
    - unless: grep "license_key={{ pillar['newrelic']['license_key'] }}" /etc/newrelic/nrsysmond.cfg
    - require_in:
      file: /etc/newrelic/nrsysmond.cfg
  file.managed:
    - name: /etc/newrelic/nrsysmond.cfg
    - replace: False
    - mode: 600
    - user: newrelic
    - group: newrelic
  service.running:
    - enable: True
    - watch:
      - pkg: newrelic-sysmond
      - file: /etc/newrelic/nrsysmond.cfg
{% endif %}
