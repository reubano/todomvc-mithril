m = require 'mithril'
count = 0

uniqueId = ->
  count += 1
  count

module.exports = class Todo
  constructor: (data) ->
    @title = m.prop data.title or ''
    @completed = m.prop data.completed or false
    @editing = m.prop data.editing or false
    @id = m.prop data.id or uniqueId()

  isEmpty: => not @title()
