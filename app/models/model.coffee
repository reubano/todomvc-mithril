prop = require 'mithril/stream'
helpers = require 'helpers'

module.exports = class Todo
  constructor: (data) ->
    helpers.assert data.id
    @title = prop data.title.trim() or ''
    @completed = prop data.completed or false
    @editing = prop data.editing or false
    @id = prop data.id

  isEmpty: => not @title()
