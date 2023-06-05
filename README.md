# Web application for efficient (easy and cheap) shopping of groceries & household items

[![Black code style](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/ambv/black)

## Formulation of the current problem

No easy(!) way of having head-to-head price comparison of specific food items between different shops on specific day/period. Why it is so?

Big local stores and supermarkets have their promotional brochures/leaflets in paper and digital forms:

- paper brochures/leaflets which are distributed into physical mailboxes of citizens as well as those leaflets are present inside stores near entrance
- proprietary mobile apps and websites of specific store/supermarket
- 'aggregational' mobile app and website "Moja Gazetka" with leaflets of many stores/supermarkets

The latter option is so far the best 'cause we have _many leaflets with prices in one place_.

But the **main inconvenience** of using those leaflets (either paper or digital) is that **leaflets are maid as carousel of HTML pages** - _aka_ paper journal or flip book.
Those pages include photos, price tags with prev/new prices, for what unit/pcs that price is, etc. Examples: [link1](https://www.biedronka.pl/pl/gazetki), [link2](https://www.lidl.pl/informacje-dla-klienta/nasze-gazetki), [link3](https://leclerc.pl/gazetki/)

> **As a customer I want to have convenient "single source of truth" - one web/mobile app which helps me to buy goods cheaply whenever I go shopping.**

The questions that must be answered and solved are:

- how to easily get/grab these prices and items names so we can have a list of all items that are promoted on specific dates (usually, its 2-3 days or 1 week)?
- how to parse/collect data from many webpages?
- where we can find APIs of those stores/supermarkets - it's much easier to work with structured JSON/XML responses

## Solution, v0.0.1

Web application with the following high-level components and functionality:

- Backend
  - web framework
    - web scraping/parsing
      - agnostic scrapping, e.g. it is possible to get data from any shop with some configurations adjustments
      - asynchronous scraping and data processing for faster I/O operations
    - data analysis
      - ETL pipeline to aggregate data into database
      - filtering, grouping, and aggregating the data to extract insights
      - data visualization: analytic dashboard with sorting/filtering, visualization, data export in different formats
    - user accounts: authorization (sign up/sign in), profile, UI settings for personalization etc.
    - admin panel
  - databases (SQL and noSQL)
    - store and retrieve data
      - design schemas
      - write queries
      - CRUD operations
      - optimize performance
  - background processing
    - display up-to-date information without any delays
  - testing
    - unit tests for your code to ensure that it is working correctly
    - load testing to ensure that the dashboard can handle high levels of traffic
- Frontend
  - design / mockups
  - lightweight UI framework (HTML/CSS/JS) or big JavaScript framework
  - visualization dashboard
  - users can enter the URL of a website they want to scrape
  - specify what data they want to extract, and view the results of the scraping and analysis
- Backend / frontend communication
  - RESTful API
  - OpenAPI docs
- DevOps
  - code repository
  - containerization
  - orchestration
  - continuous integration and delivery (CI/CD)
  - clouds services

More details about architecture and tech stack can be found in [documentation](docs/project_details/project_knowledge_base/verbose_details.md)

### Installation

```bash
git clone https://github.com/ivanprytula/price-navigator.git

# or
gh repo clone ivanprytula/price-navigator

cd price-navigator
```

#### Local setup

1. Start [status|stop] PostgreSQL server: `sudo systemctl start postgresql` or `sudo service postgresql start`
2. Create a new PostgreSQL database with...
   1. PostgreSQL client `psql` (steps below)
   2. Shell CLI [createdb](https://www.postgresql.org/docs/current/app-createdb.html)
   3. pgAdmin
   4. Your preferable way
3. Set the environment variables, there are 2 options:
   1. Create `.env` file in the root of your project with all needed variables. Then `export DJANGO_READ_DOT_ENV_FILE=True`
   2. Use a local environment manager like [direnv](https://direnv.net/)
4. Dry run w/o migrations - just spin off _classic_ `./manage.py runserver` or `./manage.py runserver_plus` (w/ watchdog and Werkzeug debugger)
5. Visit <http://127.0.0.1:8000/>
6. Setting up your users:
   1. **normal user account**: just go to Sign Up and fill out the form. Once you submit it, you'll see a "Verify Your E-mail Address" page. Go to your console to see a simulated email verification message. Copy the link into your browser. Now the user's email should be verified and ready to go.
   2. `python manage.py createsuperuser`

```bash
# verbose option
sudo -u postgres -i psql

CREATE DATABASE price_navigator;
CREATE USER price_dwh_user WITH PASSWORD 'my_password';
# it is recommended to set these stuff also
# https://docs.djangoproject.com/en/4.2/ref/databases/#optimizing-postgresql-s-configuration
ALTER ROLE price_dwh_user SET client_encoding TO 'utf8';
ALTER ROLE price_dwh_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE price_dwh_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE "price_navigator" to price_dwh_user;

# jic, if you are in a hurry, here is one-liner option
sudo -u postgres psql -c 'create database price_navigator;'
postgres=# \l  # list all databases
```

#### Dockerized setup

```bash
make up
make down
```
