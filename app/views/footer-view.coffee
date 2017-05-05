m = require 'mithril'

module.exports = (ctrl) ->
  amountCompleted = ctrl.amountCompleted()
  amountActive = ctrl.todos.list.length - amountCompleted
  es = if amountActive is 1 then '' else 's'
  actClass = if ctrl.filter() is 'active' then 'selected' else ''
  cmpClass = if ctrl.filter() is 'completed' then 'selected' else ''
  blankClass = if ctrl.filter() is '' then 'selected' else ''

  m 'footer#footer', [
    m 'span#todo-count', [m('strong', amountActive), " item#{es} left"]
    m 'ul#filters', [
      m 'li', [
        m 'a[href=/]', {config: m.route, class: blankClass}, 'All']
      m 'li', [
        m 'a[href=/active]', {config: m.route, class: actClass}, 'Active']
      m 'li', [
        m 'a[href=/completed]', {config: m.route, class: cmpClass}, 'Completed']
    ]

    if amountCompleted is 0
      ''
    else
      m 'button#clear-completed',
        onclick: ctrl.clearCompleted,
        'Clear completed'
  ]
