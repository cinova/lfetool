#######
lfetool
#######

.. image:: resources/images/logo-small.png

*An Erlang Lisper's Tool for Admin Tasks, Project Creation, and Infrastructure*


Introduction
============

Currently, the script supports these basic options:

* ``help`` or ``-h``
* ``version`` or ``-v``
* ``extract`` or ``-x``

And these commands:

* ``install``
* ``update``
* ``new``
* ``tests``
* ``repl``
* ``info``
* ``download``

Usage information for each of these is linked to below in the "Usage" section.


Installation
============


Stable
------

Download the `shell script`_ and save it to a directory in your ``$PATH``. For
example:

.. code:: bash

    $ curl -L -o ./lfetool https://raw.github.com/lfe/lfetool/stable/lfetool
    $ bash lfetool install


Dev
---
.. code:: bash

    $ curl -L -o ./lfetool https://raw.github.com/lfe/lfetool/dev-v1/lfetool
    $ bash lfetool install


Both
----

This will install lfetool to ``/usr/local/bin``. Depending upon how the
permissions for your chossen path are setup, you may need to use ``sudo``.

If you installed with ``sudo`` but would like to be able to self-update the
script in the future, you should also change the ownership:

.. code:: bash

    $ chown $USER /usr/local/bin/lfetool

To run ``lfetool`` more quickly, you can pre-extract the executable:

.. code:: bash

    $ lfetool -x

This will be done for you eventually if you execute the ``lfetool repl`` command.



Usage
=====


``lfetool`` Options
-------------------

``lfetool`` offer several command-line options/flags. The details are presented
on the "options" manual page:

* `Options`_


``lfetool`` Commands
--------------------

Details on each of the commands listed below and the subcommands they offer
are linked to individual pages:

* `Install Command`_
* `Update Command`_
* `New Command`_
* `Tests Command`_
* `REPL Command`_
* `Info Command`_
* `Download Command`_


Development
===========

Branches
--------

The following branches are used by this project:

* stable - what you should use for all your production needs; currently on
  v1.x; this is the default branch
* dev-v1 - on-going improvements to the v1.x series
* dev-v2 - a convertion of lfetool from a large Bash script to an LFE project;
  the v2.x series (every release to stable gets merged into dev-v2, to benefit
  from any bug fixes/hot-fixes/template improvements/additions/etc.)
* master - this is kept around for legacy purposes (there are some projects
  still using the old v1.0.x series)

Creating lfetool Plugins
------------------------

*Developing additional lfetool commands*

This section has been created for those that would like to submit patches/pull
requests to lfetool for bug fixes and/or new features. At the very least, it
should provide a means for understanding what is needed in order to add new
commands to lfetool.

Adding new commands to lfetool is as simple as creating a new plugin. One can
start by either copying an existing plugin that most closely resembles the sort
of plugin you want to create, or starting completely from scratch.

For those that wish to start from scratch, the following dev guide is
provided:

* `Create the Plugin`_
* `Integrate the Plugin`_
* `Documentation and Autocompletion`_
* `Testing the Plugin`_


.. Links
.. -----
.. _LFE rebar: hhttps://github.com/oubiwann/lfe-sample-rebar-plugin
.. _lfe-skel: https://github.com/lfe/skeleton-project
.. _shell script: https://raw.github.com/lfe/lfetool/master/lfetool
.. _exemplar: https://github.com/lfe/exemplar
.. _Twitter Bootstrap: http://getbootstrap.com/
.. _rebar: https://github.com/rebar/rebar
.. _erlang.mk: https://github.com/extend/erlang.mk
.. _relx: https://github.com/erlware/relx
.. _Create the Plugin: doc/dev-guide/01-create.rst
.. _Integrate the Plugin: doc/dev-guide/02-integrate.rst
.. _Documentation and Autocompletion: doc/dev-guide/03-docs.rst
.. _Testing the Plugin: doc/dev-guide/04-tests.rst
.. _Install Command: doc/manual/install.rst
.. _Options: doc/manual/options.rst
.. _Update Command: doc/manual/update.rst
.. _New Command: doc/manual/new.rst
.. _Tests Command: doc/manual/tests.rst
.. _REPL Command: doc/manual/repl.rst
.. _Info Command: doc/manual/info.rst
.. _Download Command: doc/manual/download.md

