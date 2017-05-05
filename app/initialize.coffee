require = global.require
m = require 'mithril'
Application = require 'application'
routes = require 'routes'

m.route.mode = 'hash'

document.addEventListener 'DOMContentLoaded', ->
  app = new Application()
  location = document.getElementById('todoapp')
  m.route location, '/', routes(app)
