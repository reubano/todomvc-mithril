helpers = require 'helpers'
Todo = require './model'

module.exports = class Todos
  list: []
  fetch: ->
    promise = Promise.resolve helpers.store().map (todo) -> new Todo todo
    promise.then (result) => @list = result
    promise

  save: => helpers.store @list
