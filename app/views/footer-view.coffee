m = require 'mithril'

module.exports = (vnode) ->
  ctrl = vnode.state.ctrl
  es = if ctrl.remaining() is 1 then '' else 's'
  getClass = (status) -> if ctrl.status() is status then 'selected' else ''

  m 'footer.footer', [
    m 'span.todo-count', [m('strong', ctrl.remaining()), " item#{es} left"]
    m 'ul.filters', [
      m 'li', [
        m 'a[href=/]', {oncreate: m.route.link, class: getClass()}, 'All']
      m 'li', [
        m 'a[href=/active]', {
          oncreate: m.route.link, class: getClass 'active'}, 'Active']
      m 'li', [
        m 'a[href=/completed]', {
          oncreate: m.route.link, class: getClass 'completed'}, 'Completed']
    ]

    if ctrl.completed()
      m 'button.clear-completed',
        onclick: ctrl.clearCompleted,
        'Clear completed'
  ]
