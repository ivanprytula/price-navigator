Work notes
==========

Specific problems/issues solved while setup and working on this project

[Local setup] Get rid of whitenoise "No directory at" warning
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It was necessary to add such a fixture because the pytest job in the CI workflow had failed.

.. code-block::
   :caption: price_navigator/conftest.py

    @pytest.fixture(autouse=True)
    def whitenoise_autorefresh(settings):
        """
        Get rid of whitenoise "No directory at" warning, as it's not helpful when running tests.
        NB: https://whitenoise.readthedocs.io/en/latest/django.html#WHITENOISE_AUTOREFRESH

        Related:
            - https://github.com/evansd/whitenoise/issues/215
            - https://github.com/evansd/whitenoise/issues/191
            - https://github.com/evansd/whitenoise/commit/4204494d44213f7a51229de8bc224cf6d84c01eb
        """
        settings.WHITENOISE_AUTOREFRESH = True


[Local setup] Separate database env variables for main functionality and tests
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. In most basic case we oftenly use classic ``postgres`` user for main database and testing::

    DATABASE_URL=postgres://postgres:postgres@localhost:5432/postgres

In such case all we need is just to add corresponding changes to settings.py and/or to ``.env`` file.

For this project I create separate user in PostgreSQL's server and dedicated database.
If such user doesn't have ``superuser`` privileges for databases (cf. ``postgres`` user) then it's **important** to have separate database config for testing.

Firstly, when pytest runs tests suite with *regular* user it cannot create by default test db with *test_* prefix, e.g. ``test_<db_name>``.

.. code-block::
   :caption: example of pytest's traceback

    self = <django.db.backends.utils.CursorWrapper object at 0x7f1ab6a5ef80>, sql = 'CREATE DATABASE "test_price_navigator" ', params = None
    ignored_wrapper_args = (False, {'connection': <DatabaseWrapper vendor='postgresql' alias='__no_db__'>, 'cursor': <django.db.backends.utils.CursorWrapper object at 0x7f1ab6a5ef80>})
    _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
    self = <django.db.utils.DatabaseErrorWrapper object at 0x7f1ab6a5ee00>, exc_type = <class 'psycopg2.errors.InsufficientPrivilege'>, exc_value = InsufficientPrivilege('permission denied to create database\n')
    traceback = <traceback object at 0x7f1ab6a76c00>
    Got an error creating the test database: permission denied to create database

Secondly, on CI pytest job usually contains typical configuration for db connection:

.. code-block::

    DATABASE_URL: 'postgres://postgres:postgres@localhost:5432/postgres'

But with just one DATABASE_URL in ``settings/test.py`` we've got the same error as during local pytest's run:

.. code-block::
   :caption: example of pytest's traceback on CI

    dsn = 'dbname=postgres client_encoding=UTF8 host=test_price_navigator'
    connection_factory = None, cursor_factory = <class 'psycopg2.extensions.cursor'>
    kwargs = {'client_encoding': 'UTF8', 'dbname': 'postgres', 'host': 'test_price_navigator'}
    kwasync = {}

    E  RuntimeWarning: Normally Django will use a connection to the 'postgres' database to avoid running initialization queries against the production database when it's not needed (for example, when running tests). Django was unable to create a connection to the 'postgres' database and will use the first PostgreSQL database instead.

Thus, we need to add TEST_DATABASE_URL to ``settings/test.py`` and ``ci.yml`` > pytest job.

Docker Compose services local setup specificity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In case of using combo/base + override compose files ``docker compose -f local.yml -f docker-compose.dev.yml`` for celeryworker/celerybeat/flower services we **must also** inherit **env_file** attrs from django service with shortcut ``<<: *django``.

In most cases, it’s best to put each Dockerfile in an empty directory. Then, add to that directory only the files needed for building the Dockerfile. To increase the build’s performance, you can exclude files and directories by adding a .dockerignore file to that directory as well.

Refs:

* `docker build using a .dockerignore file <https://docs.docker.com/engine/reference/commandline/build/#use-a-dockerignore-file>`_
* `.dockerignore file details <https://docs.docker.com/engine/reference/builder/#dockerignore-file>`_

**NB:** removing `.ipython` dir was enough to re-build images. If not - remove also `.mypy_cache` / `.pytest_cache`

Changing export USE_DOCKER=true >> export USE_DOCKER=True in ``export_env_vars.sh`` as well as ``if env.bool("USE_DOCKER", default=False):`` fixed missed debug-toolbar when use build/up containers with command:
``docker compose -f docker-compose.yml -f docker-compose.dev-with-environment-attribute.yml up --build``.

How to debug in running container with breakpoint()?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Option 1
~~~~~~~~~

Check  `coockiecutter-django docs <https://cookiecutter-django.readthedocs.io/en/latest/developing-locally-docker.html#ipdb>`_

Option 2 (old tip, need to double-check)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 The built-in breakpoint(), when called with defaults, can be used instead of ``import pdb; pdb.set_trace()``
1. In docker-compose.yml add these lines for **django** service `link. <https://docs.docker.com/compose/compose-file/compose-file-v3/#domainname-hostname-ipc-mac_address-privileged-read_only-shm_size-stdin_open-tty-user-working_dir>`_

.. code-block::

    stdin_open: true
    tty: true

2. Re-run containers/services
3. docker attach <container_id_of_django_posts_to_telegram_web>
4. You can interact with container's stdin/stdout/stderr, i.e. with (Pdb).


How to list directories with particular depth?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block::

    # option 1
    sudo apt-get install tree
    tree -a -L 2 -I venv --dirsfirst

    # option 2
    find . -mindepth 2 -maxdepth 2 -type d

    # option 3
    du --exclude=venv --exclude=.git --max-depth=2 -h



