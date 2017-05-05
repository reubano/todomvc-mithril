m = require 'mithril'
helpers = require 'helpers'
Todo = require './model'
Todos = require './collection'
_ = require 'lodash'

module.exports = class ViewModel
  constructor: () ->
    @filter = m.prop m.route.param('filter') or ''
    @title = m.prop ''

  todos: if @todos? then @todos else new Todos()
  isEmpty: => not @title()
  data: => title: @title()
  resetData: => @title ''
  hasChanged: (todo) -> todo.title() isnt todo.previousTitle

  add: =>
    unless @isEmpty()
      todo = new Todo @data()
      @todos.list.push todo
      @todos.save()
      @resetData()

  remove: (todo, pred) =>
    if todo?.id
      @todos.list.splice todo.id, 1
      ids = [todo.id]
    else if pred
      filtered = _.filter @todos.list, pred
      ids = _.map filtered, 'id'
      _.remove @todos.list, pred

    @todos.save()

  edit: (todo) ->
    todo.previousTitle = todo.title()
    todo.editing true

  isVisible: (todo) =>
    switch @filter()
      when 'active' then not todo.completed()
      when 'completed' then todo.completed()
      else true

  toggle: (todo) ->
    todo.completed not todo.completed()
    @todos.save()

  doneEditing: (todo, index) =>
    if todo.editing()
      todo.editing false

      if todo.isEmpty()
        @remove todo
      else if @hasChanged todo
        @todos.save()

  cancelEditing: (todo) ->
    todo.title todo.previousTitle
    todo.editing false

  clearTitle: => @title ''

  clearCompleted: => @remove null, (todo) -> todo.completed()

  amountCompleted: =>
    counted = _.countBy @todos.list, (todo) -> todo.completed()
    counted.true or 0

  allCompleted: => _.every @todos.list, (todo) -> todo.completed()

  completeAll: =>
    completed = not @allCompleted()

    for todo in @todos.list
      if todo.completed() isnt completed
        todo.completed completed
        @todos.save()
