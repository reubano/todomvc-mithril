m = require 'mithril'
helpers = require 'helpers'
config = require 'config'
Todo = require './model'

module.exports = class Todos
  list: []
  fetch: ->
    m.request {method: 'GET', url: config.api}
      .then (response) => @list = (new Todo todo for todo in response.objects)
      .catch (e) -> console.error e.message

  add: (data) =>
    m.request {method: 'POST', url: config.api, data}
      .then (response) => @list.push new Todo response
      .catch (e) -> console.error e.message

  delete: (ids) =>
    @list = helpers.filter @list, (todo) -> todo.id() not in ids

    for id in ids
      m.request method: 'DELETE', url: "#{config.api}/#{id}"

  update: (todo, data) -> m.request
    method: 'PATCH'
    url: "#{config.api}/#{todo.id}"
    data: data or {title: todo.title(), completed: todo.completed()}
