---
layout: default
title: Features
permalink: /features/
---

# Features

**The Rebels Manager empowers everyone at their own level, providing them a feature set to recruit and organize groups easily.**

Features marked with a ✔️ are fully or partially implemented.

## For Working Group Coordinators

* Overview of the local branch activity (reports)
* Email all members of the working group

## For Local Chapter Coordinators

* Overview of all local chapters activity (reports)
* Detailed overview of the local chapter activity (reports)
* Email all/specific members of the local chapter
* Text message all/specific members of the local chapter
* Manage members of the local chapter ✔️
* Move someone to another local chapter
* Manage working groups memberships ✔️
* Flag someone as coordinator of the chapter
* Tag members based on custom needs ✔️

## For National Coordinators

* Detailed overview of all local chapters activity (reports)
* Overview of current coordinators in the country (local chapters and working groups)
* Email all/specific members
* Text message all/specific members
* Manage members ✔️
* Segment members by tag, location, skill or affinity
* Tag members based on custom needs ✔️
* Report about arrests #

## For International Coordinators

* Overview of all national branches activity (reports)

---

<ul>
   {% for item in site.data.menu.docs %}
      <li><a href="{{ item.url }}">{{ item.title }}</a></li>
   {% endfor %}
</ul>
