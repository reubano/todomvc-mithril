m = require 'mithril'
helpers = require 'helpers'

module.exports = (vnode) ->
  ctrl = vnode.state.ctrl

  m 'ul.todo-list', [
    ctrl.todos.list.filter(ctrl.isVisible).map (todo) ->
      completed = if todo.completed() then 'completed' else ''
      editing = if todo.editing() then ' editing' else ''
      doneFunc = -> ctrl.save todo
      cancelFunc = -> ctrl.reset todo

      m 'li', {class: "#{completed}#{editing}", key: todo.id}, [
        m '.view', [
          m 'input.toggle[type=checkbox]',
            onclick: m.withAttr 'checked', -> ctrl.toggle todo
            checked: todo.completed()

          m 'label', {ondblclick: -> ctrl.edit todo}, todo.title()
          m 'button.destroy', onclick: -> ctrl.remove todo
        ]

        m 'input.edit',
          value: todo.title()
          onkeyup: helpers.watchInput doneFunc, cancelFunc
          onblur: doneFunc
          oninput: m.withAttr 'value', todo.title
          onupdate: (vnode) -> ctrl.focus vnode, todo
      ]
  ]
