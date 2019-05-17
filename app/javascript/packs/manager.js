// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '../css/manager/main.scss'

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("trix")
require("@rails/actiontext")

import $ from 'jquery'
window.$ = $

import 'controllers'
import 'foundation-sites'

window.App = {}

App.init = () =>
  $(document).foundation()

document.addEventListener('DOMContentLoaded', function(event) {
  App.init()
});
