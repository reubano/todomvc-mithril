prop = require 'mithril/stream'
count = 0

uniqueId = ->
  count += 1
  count

class Todo
  constructor: (data) ->
    @title = prop data.title?.trim() or ''
    @completed = prop data.completed or false
    @editing = prop data.editing or false
    @id = data.id or uniqueId()

  isEmpty: => not @title()

module.exports =
  Todo: Todo
  Todos: class Todos
    list: []
    fetch: ->
      promise = Promise.resolve helpers.store().map (todo) -> new Todo todo
      promise.then (result) => @list = result
      promise

    save: => helpers.store @list
