stream = require 'mithril/stream'
count = 0

uniqueId = ->
  count += 1
  count

class Todo
  constructor: (title) ->
    @title = stream title.trim()
    @completed = stream false
    @editing = stream false
    @id = uniqueId()

  isEmpty: => not @title()

module.exports =
  Todo: Todo
  Todos: class Todos
    constructor: (titles) ->
      titles = titles or []
      @list = titles.map (title) -> new Todo title
