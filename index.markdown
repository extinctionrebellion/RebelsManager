---
layout: default
---

The Rebellion Manager is the swiss knife online platform for national branches. It is currently used by:

* [Extinction Rebellion Belgium](https://www.extinctionrebellion.be)

Rebels joining the rebellion are added to decentralized databases, making the data available to national and local chapters coordinators. The Rebels Manager gives an overview of the rebellion activity to Extinction Rebellion International Support Team.

# Current Features

* Local chapters and working groups management
* _Join the Rebellion!_ form
* Synchronized with Mailtrain for national and local lists
* Rebels can update their own profile

# Expected Features

* Multi-countries
* Customizable recruitment forms
* Encrypted email and phone number, never shown to coordinators
* Built-in mass emailing relying on [Mailtrain](https://mailtrain.org)
* Built-in mass text messaging using a linked device
* Rebels tagging and segmentation by location, skills or affinities

# Main Goals

* Make it easy to manage local chapters and rebels
* Send emails and text messages easily from a single place
* Allow rebels to update their own details anytime
* Gamify the rebellion by showing each and everyone progress as a rebel
* Provide an overview at each level: local, national and international

---

<ul>
   {% for item in site.data.menu.docs %}
      <li><a href="{{ item.url }}">{{ item.title }}</a></li>
   {% endfor %}
</ul>
