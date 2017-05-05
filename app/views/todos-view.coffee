m = require 'mithril'
helpers = require 'helpers'

module.exports = (ctrl) ->
  m 'ul#todo-list', [
    ctrl.todos.list.filter(ctrl.isVisible).map (todo) ->
      completed = if todo.completed() then 'completed' else ''
      editing = if todo.editing() then ' editing' else ''
      doneFunc = -> ctrl.doneEditing todo
      cancelFunc = -> ctrl.cancelEditing todo

      m 'li', {class: "#{completed}#{editing}", key: todo.id()}, [
        m '.view', [
          m 'input.toggle[type=checkbox]',
            onclick: m.withAttr('checked', -> ctrl.toggle todo)
            checked: todo.completed()

          m 'label', {ondblclick: -> ctrl.edit todo}, todo.title()
          m 'button.destroy', onclick: -> ctrl.remove todo
        ]

        m 'input.edit',
          value: todo.title()
          onkeyup: helpers.watchInput doneFunc, cancelFunc
          oninput: m.withAttr 'value', (value) ->
            m.redraw.strategy 'none'
            todo.title value

          config: (element) -> if todo.editing() then element.focus()
          onblur: doneFunc
      ]
  ]
