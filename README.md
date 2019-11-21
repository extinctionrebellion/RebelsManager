# README

![Depfu](https://img.shields.io/depfu/extinctionrebellion/RebelsManager)

You can start using the Rebels Manager for our own national branch or even at a local group/chapter level, but the app allows to manage multiple local groups/chapters. Please have a look at [our wiki](https://github.com/extinctionrebellion/RebelsManager/wiki) for more details, including a demo and screenshots.

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

## Database setup (PostgreSQL)

```
rails db:create db:migrate db:seed
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

No tests yet. [RSpec setup](https://github.com/extinctionrebellion/RebelsManager/issues/80) ready soon.

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
