---
layout: default
title: Security
permalink: /security/
---

# Security

## Current scope

* Single database (single country), not hosted on the national server yet
* Authentication using the open-source Devise gem
* Users management available to admin users only
* Basic user tracking about their last login (IP, time)
* Data can be posted only from allowed origins (eg. national/local website)
* Regular database backups
* Emails addresses sent to Mailtrain
* Email addresses and phone numbers shown to users and in exports
* Data shared with error reporting software (Sentry)
* No tracking using external services

## Expected scope

* Multiple databases: one for each national branch, hosted on its own encrypted disk
* Two-factor authentication for all users
* Encrypted email and phone numbers
* Email addresses and phone numbers never shown to users and not available in exports
* Email addresses not available on Mailtrain
* Security-focused code review for all updates
* No sensitive data shared with error reporting software

Contribute to this list by [submitting a pull request for this page](https://github.com/extinctionrebellion/RebelsManager/blob/gh-pages/security.markdown).

---

<ul>
   {% for item in site.data.menu.docs %}
      <li><a href="{{ item.url }}">{{ item.title }}</a></li>
   {% endfor %}
</ul>
