m = require 'mithril'

module.exports = (vnode) ->
  ctrl = vnode.state.ctrl
  es = if ctrl.remaining() is 1 then '' else 's'

  m 'footer.footer', [
    m 'span.todo-count', [m('strong', ctrl.remaining()), " item#{es} left"]
    m 'ul.filters', ['all', 'active', 'completed'].map (status) ->
      m 'li',
        m 'a', {
          href: "/#{status}"
          oncreate: m.route.link
          onupdate: m.route.link
          class: if ctrl.status() is status then 'selected' else ''
        }, status

    if ctrl.completed()
      m 'button.clear-completed', {onclick: ctrl.clearCompleted},
        'Clear completed'
  ]
