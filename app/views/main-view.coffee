m = require 'mithril'
todosView = require './todos-view'
footerView = require './footer-view'
helpers = require 'helpers'
focused = false

module.exports = (ctrl) ->
  [
    m 'header#header', [
      m('h1', 'todos')
      m 'input#new-todo[placeholder="What needs to be done?"]',
        onkeyup: helpers.watchInput(ctrl.add, ctrl.clearTitle)
        value: ctrl.title()
        oninput: m.withAttr('value', ctrl.title)
        config: (element) ->
          if not focused
            element.focus()
            focused = true
    ]

    m 'section#main',
      style: display: if ctrl.todos.list.length then '' else 'none'
      [
        m 'input#toggle-all[type=checkbox]',
          onclick: ctrl.completeAll
          checked: ctrl.allCompleted()

        todosView(ctrl)
      ]

    if ctrl.todos.list.length is 0 then '' else footerView(ctrl)
  ]
