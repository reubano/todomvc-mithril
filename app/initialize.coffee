m = require 'mithril'
Application = require 'application'
routes = require 'routes'

m.route.prefix = ''

location = document.getElementById 'todoapp'
m.route location, '/', routes Application
