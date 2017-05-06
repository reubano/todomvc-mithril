prop = require 'mithril/stream'
count = 0

uniqueId = ->
  count += 1
  count

module.exports = class Todo
  constructor: (data) ->
    @title = prop data.title.trim() or ''
    @completed = prop data.completed or false
    @editing = prop data.editing or false
    @id = prop data.id or uniqueId()

  isEmpty: => not @title()
