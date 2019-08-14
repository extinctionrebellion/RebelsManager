# README

This app is currently used by XR Belgium. You can start using it for our own national branch or even at a local group level, but the app allows to manage multiple local groups.

## Ruby version

2.6.3

## Database setup (PostgreSQL)

```
rails db:create
rails db:migrate
```

## Deploying to Heroku

TODO.

## ENV variables

- POSTGRES_USER
- POSTGRES_PASSWORD
- POSTGRES_HOST
- SENTRY_DSN (for reporting errors to Sentry)
- MAILTRAIN_REBELS_LIST_ID
- MAILTRAIN_API_TOKEN
- MAILTRAIN_API_ENDPOINT (eg. https://lists.extinctionrebellion.be/api)
- XR_BRANCH_TIMEZONE (eg. "Europe/Tallinn", "PST" or "UTC")

## Tests

No tests yet.
