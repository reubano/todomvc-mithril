prop = require 'mithril/stream'
Model = require 'model'

module.exports = class Controller
  constructor: (attrs) ->
    @status = prop attrs.status
    @title = prop ''
    @filterValue = prop ''
    @todos = new Model.Todos ['pizza', 'sausage']

  update: (attrs) => @status attrs.status

  isEmpty: => not @title()

  add: =>
    unless @isEmpty()
      todo = new Model.Todo @title()
      @todos.list.push todo
      @clearTitle()
      @clearFilter()

  remove: (todo, pred) =>
    pred = pred or (_todo) -> _todo.id isnt todo.id
    @todos.list = @todos.list.filter pred

  edit: (todo) ->
    todo.previousTitle = todo.title()
    todo.editing true

  isVisible: (todo) =>
    visible = switch @status()
      when 'active' then not todo.completed()
      when 'completed' then todo.completed()
      else true

    if visible and @filterValue()
      todo.title().includes @filterValue()
    else
      visible

  toggle: (todo) ->
    todo.completed not todo.completed()

  save: (todo) =>
    if todo.editing()
      todo.editing false

      if todo.isEmpty()
        @remove todo

  reset: (todo) ->
    todo.title todo.previousTitle
    todo.editing false

  clearTitle: => @title ''
  clearFilter: => @filterValue ''

  clearCompleted: => @remove null, (todo) -> not todo.completed()

  completed: =>
    filtered = @todos.list.filter (todo) -> todo.completed()
    filtered.length

  remaining: =>
    filtered = @todos.list.filter (todo) -> not todo.completed()
    filtered.length

  allCompleted: => @todos.list.every (todo) -> todo.completed()

  completeAll: =>
    completed = not @allCompleted()

    @todos.list.forEach (todo) =>
      if todo.completed() isnt completed
        @toggle todo

  focus: (vnode, todo) ->
    if todo.editing() and vnode.dom isnt document.activeElement
      vnode.dom.focus()
