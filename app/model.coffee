prop = require 'mithril/stream'
count = 0

uniqueId = ->
  count += 1
  count

class Todo
  constructor: (title) ->
    @title = prop title.trim()
    @completed = prop false
    @editing = prop false
    @id = uniqueId()

  isEmpty: => not @title()

module.exports =
  Todo: Todo
  Todos: class Todos
    constructor: (titles) ->
      titles = titles or []
      @list = titles.map (title) -> new Todo title
