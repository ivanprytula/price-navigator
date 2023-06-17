# Python best practices

## General

- One virtual environment per project
  - Isolation
  - Different projects have different dependency versions
  - You don't want to mess up the system Python
- Structure your code and projects
  - Package and module structure gives an overview about the project
  - Modular design == better re-usability
- Utilize the capabilities of your editor
  - Efficient and fluent development
  - There's plenty of tools to make your daily programming easier, why would you not use them
- Use existing solutions
  - Python Standard Library is extensive - and stable!
  - There are 370k+ packages in PyPI
  - Someone has most likely solved the problem you're trying to solve
  - Spend 5 minutes doing a web search before starting to solve a new problem
- Learn how to debug efficiently
  - You won't write completely stable code anyway - impossible looking conditions will occur
  - When something is not working as expected, there are plenty of tools out there to help you figure out what's going on
- Test your code
  - No surprises (especially in production)
  - Make sure that everything works as expected
  - Make sure that old stuff works as expected after introducing new features (regression)
  - Tests give you confidence while refactoring
  - Good tests demonstrate the use cases of application, i.e. they also document the implementation
- Write high quality code
  - Easy to read
  - Better maintainability
  - Better quality == less bugs
- Use continuous integration and deployment
  - Make sure the tests pass
  - CI is the place where it's possible to run also some time consuming tests which the impatient developers prefer to skip on their local machines
  - Make sure there's no linting errors
  - Ideally, the place to test against all target versions and platforms
  - Overall, CI is the last resort for automatically ensuring the quality
  - Manual deployments are time consuming and error-prone, CD is automated and deterministic
  - You want to automate as much as possible, human time is expensive
  - Minimize the time required for code reviews, what could be detected with automatic tools, should be detected by using those tools, human time is expensive
- Unclutter the repo with `.gitignore`
- No passwords in the code: use configuration files or environment variables
- Have a README.md[.rst]
- If you use third-party libraries, have a requirements.txt/Pipfile/pyproject.toml
- Format your code
- Remove unused imports
- Remove unused variables
- Follow PEP-8 naming conventions

## 5 Tips To Achieve Low Coupling In Your Python Code

[source link](https://www.youtube.com/watch?v=qR4-PBLUZNw)

- Tip 1: Avoid deep inheritance relationships
- Tip 2: Separate creating resources from using them
- Tip 3: Introduce abstractions
- Tip 4: Avoid inappropriate intimacy
- Tip 5: Introduce an intermediate data structure

## Specifying Versions of a Package

[Pipenv documentation](https://pipenv-fork.readthedocs.io/en/latest/basics.html#specifying-versions-of-a-package)

The use of ~= is preferred over the == identifier as the latter prevents pip/pipenv/poetry/etc from updating the packages.
It locks the major version of the package and install version 1.2 and any **minor** updates, but **not 2.0**.

```shell
$ pip install "requests~=1.2"
```

## Testing

1. If it can break, it should be tested. This includes models, views, forms, templates, validators, and so forth.
2. Each test should generally only test one function.
3. Keep it simple. You do not want to have to write tests on top of other tests.
4. Run tests whenever code is PULLed or PUSHed from the repo and in the staging environment before PUSHing to production.
5. When upgrading to a newer version of Django:
   - upgrade locally,
   - run your test suite,
   - fix bugs,
   - PUSH to the repo and staging, and then
   - test again in staging before shipping the code.

## English in IT area

1. Emphasis on **functional** language, constant expressions that customers use in the work environment.
2. Phrases like "could you be so kind", "I was wondering if you could", more "please" and "thank you" will help make English more polite.
3. Objectives in the ability to **communicate** effectively. Therefore, it is important to emphasize the development of **listening** skills.
4. Certificates of English - IELTS, TOEFL, FCE, CPE - adequate tests. It's good to have them valid/"fresh".
5. Adequate evaluation of English level - speaking, writing, listening and reading.
