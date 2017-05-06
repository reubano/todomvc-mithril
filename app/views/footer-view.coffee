m = require 'mithril'

module.exports = (vnode) ->
  ctrl = vnode.state.ctrl
  es = if ctrl.remaining() is 1 then '' else 's'
  actClass = if ctrl.status() is 'active' then 'selected' else ''
  cmpClass = if ctrl.status() is 'completed' then 'selected' else ''
  blankClass = if ctrl.status() is '' then 'selected' else ''

  m 'footer.footer', [
    m 'span.todo-count', [m('strong', ctrl.remaining()), " item#{es} left"]
    m 'ul.filters', [
      m 'li', [
        m 'a[href=/]', {oncreate: m.route.link, class: blankClass}, 'All']
      m 'li', [
        m 'a[href=/active]', {
          oncreate: m.route.link, class: actClass}, 'Active']
      m 'li', [
        m 'a[href=/completed]', {
          oncreate: m.route.link, class: cmpClass}, 'Completed']
    ]

    if ctrl.completed()
      m 'button.clear-completed',
        onclick: ctrl.clearCompleted,
        'Clear completed'
  ]
