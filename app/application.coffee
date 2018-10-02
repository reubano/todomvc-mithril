m = require 'mithril'
Controller = require 'controller'
view = require 'view'

module.exports =
  oninit: (vnode) ->
    vnode.state.ctrl = new Controller vnode.attrs

  onbeforeupdate: (vnode) ->
    vnode.state.ctrl.update vnode.attrs

  view: (vnode) ->
    ctrl = vnode.state.ctrl

    [
      view.headerView vnode

      m 'section.main', {
        style: display: if ctrl.todos.list.length then '' else 'none'
      }, [
        m 'input#toggle-all.toggle-all[type=checkbox]', {
          onclick: ctrl.completeAll
          checked: ctrl.allCompleted()
        }

        m 'label', {for: 'toggle-all'}, 'Mark all as complete'
        view.todosView vnode
      ]

      if ctrl.todos.list.length
        view.footerView vnode
    ]

