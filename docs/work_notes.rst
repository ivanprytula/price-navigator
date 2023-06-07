Work notes
==========

Specific problems/issues solved while setup and working on this project
-----------------------------------------------------------------------

Get rid of whitenoise "No directory at" warning
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It was necessary to add such a fixture because the pytest job in the CI workflow had failed.

.. code-block::
   :caption: price_navigator/conftest.py

    @pytest.fixture(autouse=True)
    def whitenoise_autorefresh(settings):
        """
        Get rid of whitenoise "No directory at" warning,
        as it's not helpful when running tests.

        ...the rest docstring is omitted for brevity...
        """
        settings.WHITENOISE_AUTOREFRESH = True


Separate database env variables for main functionality and tests
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
