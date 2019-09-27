# README

![Depfu](https://img.shields.io/depfu/extinctionrebellion/RebelsManager)

This app is currently used by XR Belgium. You can start using it for our own national branch or even at a local group level, but the app allows to manage multiple local groups.

## Ruby version

2.6.3

## Database setup (PostgreSQL)

```
rails db:create
rails db:migrate
```

## ENV variables

- ALLOWED_ORIGINS (eg. "extinctionrebellion.be,www.extinctionrebellion.be")
- APP_URL (eg. "https://rebels.extinctionrebellion.be")
- POSTGRES_USER
- POSTGRES_PASSWORD
- POSTGRES_HOST
- SENTRY_DSN (for reporting errors to Sentry)
- MAILTRAIN_LOCAL_GROUPS_LIST_ID
- MAILTRAIN_REBELS_LIST_ID
- MAILTRAIN_API_TOKEN
- MAILTRAIN_API_ENDPOINT (eg. "https://lists.extinctionrebellion.be/api")
- XR_BRANCH_TIMEZONE (eg. "Europe/Tallinn", "PST" or "UTC")

## Tests

No tests yet. Contributions welcome!

## Additional information

### Built With

* Ruby on Rails
* PostgreSQL

Plus a bunch of Ruby Gems, a complete list of which is at [/master/Gemfile](https://github.com/extinctionrebellion/RebelsManager/blob/master/Gemfile).

### Contributing

The Rebels Manager is 100% open source. We encourage and support an active, healthy community that accepts contributions from the public – including you!

We look forward to seeing your pull requests!

#### They contributed already 🙏

All contributors can be found at https://github.com/extinctionrebellion/RebelsManager/graphs/contributors. But yes, this is just the beginning.

### License

![GitHub](https://img.shields.io/github/license/extinctionrebellion/RebelsManager)

### Dedication

The Rebels Manager is built with love and rage.
