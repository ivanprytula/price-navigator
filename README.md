# Web application for efficient (easy and cheap) shopping of groceries & household items

## Current problem

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

## Solution, v1

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

### System design and architecture

todo UML ERD etc
...

### Tech Stack

In terms of _layers_:

"Backend Burger"

1. **Containerization**: Docker, Docker Compose
2. **Architectural patterns**: Monolithic
3. **CI/CD Tools**: GitHub Actions
4. **APIs**: RESTful API
5. **VCS**: GitHub
6. **Caching**: Browser cache, CDN
7. **Frameworks**: Django
8. **Programming language**: Python
9. **Testing**: Unit testing
10. **Database**: RDBMS (PostgreSQL), NoSQL (Redis as message broker)
11. **Third-party integrations**: email, open-source maps API

"Frontend Burger"

1. **Responsive, interactive, and dynamic web interface**: HTML5 (structure), CSS3 (style), behavior (JavaScript)
2. **Interactive visualizations**: JS libs

In terms of _technologies_:

1. **Environment setup**: shell scripts, Makefile, Docker, Docker Compose, Kubernetes
2. **Backend**: Python 3.10, Django 4.2
3. **API**: Django REST Framework, Websockets, Swagger/OpenAPI
4. **Databases servers/Docker images**: PostgreSQL, Redis, MongoDB, Cassandra
5. **Data analysis**: Pandas, NumPy, Matplotlib, Seaborn, or Plotly
6. **ETL pipeline**: Airflow
7. **Web scraping**: requests, BeautifulSoup, or Scrapy
8. **Code quality**: linters, formatters, security scanners, git hooks
9. **Testing**: Pytest, pytest-django, locust, coverage, TDD
10. **Security**: pay attention to
    - CORS
    - CSRF
    - environment variables/password/secrets management
    - Content Security Policy (CSP)
    - XSS
    - Django deployment check list
11. **UI**: HTML, CSS, JavaScript
12. **Documentation**: Markdown, reStructuredText
13. **Cloud hosting/PaaS**: AWS (EC2, S3, CloudWatch)
14. **IaaC**: Terraform or Ansible

In terms of detailed list of _dependencies/packages/libraries_:

1. Check `requirements.txt` / `pyproject.toml` / `package.json`

In terms of _tech skills / practical knowledge / experience with_:

1. Design patterns and SOLID principles
2. Data structures and algorithms
3. Experience with Python web frameworks both sync and async
4. Implement various ways of communication with client (e.g. REST API, WebSockets)
5. Implement various ways of authentication (e.g. JWT, cookie-based auth, OAuth)
6. Experience and development on different data stores (RDBMS, NoSQL, KeyStore, etc.)
7. Experience in databases optimization: indexing, query tuning, execution plans, normalization
8. Proficiency in testing
9. Experience with CI/CD, deployment tools
10. Cloud platforms (AWS/GPC/Azure) and their core services

In terms of _soft skills_:

1. Good communication skills and at least an Upper-Intermediate level of English
2. Energetic team player
3. Highly motivated, self-driven, and independent

In terms of _responsibilities_:

1. Clarifying requirements and advising on the technical approach
2. Developing site parsers and performing data cleaning and transformation
3. Maintaining, configuring, and improving integration with various third-party services
4. Ensuring coding quality and maintainability of development
5. Code review
6. Communicating with cross-functional teams that develop applications
7. Managing priorities, deadlines, and deliverables

In terms of _typical developer tools_:

1. VS Code as IDE
2. VS Code extensions:
   1. API Client: Thunder Client
   2. SQLTools
   3. PostgreSQL Management Tool
   4. ShellCheck
   5. Remote Development
   6. markdownlint
3. `.editorconfig` to maintain consistent coding styles for multiple developers
4. Browsers' Web Developer tools
5. shell alias for Git commands
6. cheat sheet of most common/oftenly used shell/CLI commands

#### Useful resources

1. **Base/core**:
   1. <https://docs.python.org/3/>
   2. <https://docs.djangoproject.com/en/4.2/>
   3. <https://docs.docker.com/>
2. **Handy web services/tools**:
    1. <https://regex101.com/>
    2. <https://jsonformatter.curiousconcept.com/>
    3. <https://www.sql-practice.com/>
    4. <https://caniuse.com/>
3. **Particular topics**:
   1. <https://www.buchanan.com/database-performance-tuning-techniques/>
   2. <https://www.digitalocean.com/community/tutorials/how-to-secure-your-django-application-with-a-content-security-policy>
   3. <https://www.laac.dev/blog/content-security-policy-using-django/>
4. **General articles/blogs/books**
   1. <https://bytebytego.com/courses/system-design-interview/foreword>
   2. <https://www.startdataengineering.com/>
5. **Inspiration/templates**
    1. <https://awesomedjango.org/>
    2. <https://github.com/donnemartin/system-design-primer>
6. **Other/pile of links**
   1. <https://www.testgorilla.com/glossary/>

##### Credits and gratitude

1. <https://github.com/erayerdin/sos-django-template>
2. <https://github.com/jefftriplett/django-startproject>
