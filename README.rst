sssd
====

Formula to set up and configure the sssd service.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``sssd``
-------

Installs the sssd package, manages the config file (sssd.conf) if desired, manages the service if desired.

``sssd.sysauth``
-------

Utilises O/S specific methods to ensure sssd is utilised by the system.

Tested with:
* CentOS 7
* Ubuntu LTS 16.04
* Debian Stretch 9.4

NOTE: Only does authconfig for RedHat based systems at this point.
