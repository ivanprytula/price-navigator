# Project --verbose details

[Requirements](#requirements)

[Installation](#installation)

[Project structure](#project-structure)

[System design and architecture](#system-design-and-architecture)

[Tech Stack](#tech-stack)

[Credits and gratitude](#credits-and-gratitude)

(#requirements)=
## Requirements

- Knowledge of your operating system: basic commands and utilities to perform everyday tasks, such as file management, process management, user management, etc.
- IDE or "text editor on steroids" ^_^
- Knowledge and desire to learn modern browsers DevTools: page inspector, console, sources, network, application, and other tabs
- [CPython 3.10+](https://www.python.org/downloads/)
- [NodeJS](https://nodejs.org/en/download) / `npm`
- [Git](https://git-scm.com/downloads), [GitHub account](https://github.com/) / [GitHub CLI](https://cli.github.com/)
- [Docker Engine](https://docs.docker.com/engine/install/), [Docker Compose v2](https://docs.docker.com/compose/)
- Databases servers (for local development w/o containers)
  - [PostgreSQL](https://www.postgresql.org/download/)
  - other
- Cloud services
  - AWS
    - [Active account](https://aws.amazon.com/) with free tier/enabled billing
    - AWS CLI [installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
  - GCP
    - [Active account](https://cloud.google.com/) with free tier/enabled billing
    - GCP CLI [installed](https://cloud.google.com/sdk/docs/install)
  - Azure
    - [Active account](https://azure.microsoft.com/en-us/) with free tier/enabled billing
    - Azure CLI [installed](https://learn.microsoft.com/en-us/cli/azure/)

(#installation)=
## Installation

Check README.md page in project root for local and containerized setup

(#project-structure)=
## Project structure

```shell
tree -a -L 1 -C -I venv --dirsfirst
tree -a -L 2 -C -I __pycache__ --dirsfirst price_navigator/

# or with Disk Usage Analyzer
du --exclude=venv --exclude=.git --exclude=.vscode --exclude=node_modules --exclude=sandbox --max-depth=2 -h
```
---

```text
# as of 18-06-2023, ab25ddfc97930e7d0c56e238cb3b104bfe41407b
price_navigator/
├── static
│   ├── css
│   ├── fonts
│   ├── images
│   ├── js
│   └── sass
├── templates
│   ├── account
│   ├── pages
│   ├── users
│   ├── 403.html
│   ├── 404.html
│   ├── 500.html
│   └── base.html

├── users
│   ├── api
│   ├── migrations
│   ├── tests
│   ├── __init__.py
│   ├── adapters.py
│   ├── admin.py
│   ├── apps.py
│   ├── context_processors.py
│   ├── forms.py
│   ├── managers.py
│   ├── models.py
│   ├── tasks.py
│   ├── urls.py
│   └── views.py
├── utils
│   ├── __init__.py
│   └── storages.py
├── __init__.py
└── conftest.py
```
---

(#system-design-and-architecture)=
## System design and architecture

![Price Navigator high-level architecture](images/project_architecture/high_level_scheme_price_navigator.png)
![Price Navigator high-level ERD](images/project_architecture/high_level_erd_price_navigator.png)



(#tech-stack)=
## Tech Stack

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
3. **API**: Django REST Framework, WebSockets, Swagger/OpenAPI
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
    - Django deployment checklist
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
4. Implement various ways of communication with clients (e.g. REST API, WebSockets)
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
5. Shell alias for Git commands
6. cheat sheet of most common/often used shell/CLI commands


(#credits-and-gratitude)=
## Credits and gratitude

1. <https://github.com/erayerdin/sos-django-template>
2. <https://github.com/jefftriplett/django-startproject>
3. <https://github.com/cookiecutter/cookiecutter-django/>
