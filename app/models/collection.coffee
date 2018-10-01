helpers = require 'helpers'
Todo = require './model'

module.exports = class Todos
  constructor: (titles) ->
    titles = titles or []
    @list = titles.map (title) -> new Todo title
