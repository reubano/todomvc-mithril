m = require 'mithril'
helpers = require 'helpers'

module.exports = (vnode) ->
  ctrl = vnode.state.ctrl
  es = if ctrl.remaining() is 1 then '' else 's'

  m 'footer.footer', [
    m 'span.todo-count', [m('strong', ctrl.remaining()), " item#{es} left"]
    m 'ul.filters', [
      ['all', 'active', 'completed'].map (status) ->
        m 'li',
          m 'a', {
            href: "/#{status}"
            oncreate: m.route.link
            onupdate: m.route.link
            class: if ctrl.status() is status then 'selected' else ''
          }, status

      m 'li', '🔍'

      m 'input', {
        placeholder: 'Search'
        value: ctrl.filterValue()
        onkeyup: helpers.watchInput null, ctrl.clearFilter
        oninput: m.withAttr 'value', ctrl.filterValue
      }
    ]

    if ctrl.completed()
      m 'button.clear-completed', {onclick: ctrl.clearCompleted},
        'Clear completed'
  ]
