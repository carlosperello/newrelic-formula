newrelic-formula
================

A saltstack formula that installs newrelic agent.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``newrelic.sysmond``
--------------------

Install the sysmond agent to monitor the server.

``Configuration``
-----------------

::

    newrelic:
      license_key: REPLACE_WITH_REAL_NEWRELIC_KEY
