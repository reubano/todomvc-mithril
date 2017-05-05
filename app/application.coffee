# controller = require 'controller'
view = require 'views/main-view'
ViewModel = require 'models/view-model'

module.exports = class Component
  controller: -> new ViewModel()
  view: view
