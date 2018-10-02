m = require 'mithril'
App = require 'application'
routes = require 'routes'

m.route.mode = 'hash'

document.addEventListener 'DOMContentLoaded', ->
  location = document.getElementById('todoapp')
  m.route location, '/', routes(App)
