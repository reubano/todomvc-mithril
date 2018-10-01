prop = require 'mithril/stream'
count = 0

uniqueId = ->
  count += 1
  count

module.exports = class Todo
  constructor: (title) ->
    @title = prop title.trim()
    @completed = prop false
    @editing = prop false
    @id = uniqueId()

  isEmpty: => not @title()
