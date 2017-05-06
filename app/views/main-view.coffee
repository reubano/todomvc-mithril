m = require 'mithril'
todosView = require './todos-view'
footerView = require './footer-view'
helpers = require 'helpers'

module.exports = (vnode) ->
  ctrl = vnode.state.ctrl
  toggleLabel = 'Mark all as complete'

  [
    m 'header#header', [
      m('h1', 'todos')
      m 'input.new-todo[placeholder="What needs to be done?"]',
        value: ctrl.title()
        onkeyup: helpers.watchInput ctrl.add, ctrl.clearTitle
        oninput: m.withAttr 'value', ctrl.title
    ]

    m 'section#main',
      style: display: if ctrl.todos.list.length then '' else 'none'
      [
        m 'input.toggle-all[type=checkbox]',
          onclick: ctrl.completeAll
          checked: ctrl.allCompleted()

        m "label[for='toggle-all']", {onclick: ctrl.completeAll}, toggleLabel
        todosView vnode
      ]

    if ctrl.todos.list.length
      footerView vnode
  ]
