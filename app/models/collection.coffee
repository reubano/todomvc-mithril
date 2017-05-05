m = require 'mithril'
helpers = require 'helpers'
Todo = require './model'

module.exports = class Todos
  constructor: ->
    @list = (new Todo todo for todo in helpers.store())

  get: (id) => _.find @list, {id}
  save: => helpers.store @list
