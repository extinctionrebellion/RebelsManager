<p align="center">
  <img src="https://cloud.extinctionrebellion.be/index.php/apps/files_sharing/publicpreview/2aTae6w9SegctmQ?x=1463&y=1314&a=true&file=readme-rebels-manager.png&scalingup=0" width="239" alt="Rebels Manager">
  <br>
  <br>
  <img src="https://img.shields.io/depfu/extinctionrebellion/RebelsManager" alt="Depfu">
  <a href="https://travis-ci.org/extinctionrebellion/RebelsManager"><img src="https://travis-ci.org/extinctionrebellion/RebelsManager.svg?branch=master" alt="Build Status"></a>
  <a href="https://codeclimate.com/github/extinctionrebellion/RebelsManager/test_coverage"><img src="https://api.codeclimate.com/v1/badges/0072c11011f025abdd37/test_coverage" alt="Test coverage (Code Climate)"></a>
</p>

<p align="center">
  <img src="https://cloud.extinctionrebellion.be/index.php/apps/files_sharing/publicpreview/SRXSf7rSxP92wHk?x=1463&y=1314&a=true&file=README%2520-%2520Screenshot.png&scalingup=0" width="700" alt="(screenshot of the Rebels Manager)">
</p>

<p align="center">
  You can start using the Rebels Manager for our own national branch or even at a local group/chapter level, but the app allows to manage multiple local groups/chapters. Please have a look at <a href="https://github.com/extinctionrebellion/RebelsManager/wiki">our wiki</a> for more details, including a demo and screenshots.
</p>

The Rebels Manager wiki
=======================

We do our best to keep our wiki up-to-date with relevant information for national branches interested in using the Rebels Manager.

* [Wiki homepage](https://github.com/extinctionrebellion/RebelsManager/wiki)
* [Roadmap](https://github.com/extinctionrebellion/RebelsManager/wiki/Roadmap)
* [Demo and screenshots 📸](https://github.com/extinctionrebellion/RebelsManager/wiki/Demo-and-Screenshots)
* [Wanna contribute?](https://github.com/extinctionrebellion/RebelsManager/wiki/Wanna-contribute%3F)

Table of Contents
=================
* [Ruby version](#ruby-version)
* [Database setup (PostgreSQL)](#database-setup-postgresql)
* [ENV variables](#env-variables)
* [Tests](#tests)
* [Additional information](#additional-information)
  * [Built With](#built-with)
  * [Contributing](#contributing)
    * [They contributed already <g-emoji class="g-emoji" alias="pray" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f64f.png">🙏</g-emoji>](#they-contributed-already-)
  * [License](#license)
  * [Dedication](#dedication)

## Ruby version

2.6.3

## Setup

- clone repo
- run the following commands (the first one is optional, depending on your machine setup):
```
$ rbenv local 2.6.3
$ bundle install
$ yarn
$ cp .env.example .env
```
- set your POSTGRES_USER in the .env ( You can use specific [file per environment](https://github.com/bkeepers/dotenv#what-other-env-files-can-i-use) and append `.local` to them if you want )
- run the following commands:
```
$ rails c
  // use the generated key to set your LOCKBOX_MASTER_KEY env variable
  irb> Lockbox.generate_key
$ rails db:prepare
```

## ENV variables

- ALLOWED_ORIGINS (eg. "extinctionrebellion.be,www.extinctionrebellion.be")
- APP_URL (eg. "https://rebels.extinctionrebellion.be")
- LOCKBOX_MASTER_KEY
- POSTGRES_USER
- POSTGRES_PASSWORD
- POSTGRES_HOST
- SENTRY_DSN (for reporting errors to Sentry)
- MAILTRAIN_API_TOKEN
- MAILTRAIN_API_ENDPOINT (eg. "https://lists.extinctionrebellion.be/api")
- MAILTRAIN_REBELS_LIST_ID
- XR_BRANCH_DEFAULT_LANGUAGE (eg. "en")
- XR_BRANCH_TIMEZONE (eg. "Europe/Tallinn", "PST" or "UTC")

## Tests

```
bundle exec rspec
```

## Additional information

### Built With

* Ruby on Rails
* PostgreSQL
* Redis (for Sidekiq)

Plus a bunch of awesome Ruby Gems, a complete list of which is at [/master/Gemfile](https://github.com/extinctionrebellion/RebelsManager/blob/master/Gemfile).

### Contributing

The Rebels Manager is 100% open source. We encourage and support an active, healthy community that accepts contributions from the public – including you!

Please have a look at our [Wanna contribute?](https://github.com/extinctionrebellion/RebelsManager/wiki/Wanna-contribute%3F) wiki page for more details about the profiles we are actively looking for.

#### They contributed already 🙏

All contributors can be found at https://github.com/extinctionrebellion/RebelsManager/graphs/contributors. Thanks a lot to all of them!

### License

![GitHub](https://img.shields.io/github/license/extinctionrebellion/RebelsManager)

### Dedication

The Rebels Manager is built with love and rage. We believe in open source software for good.
