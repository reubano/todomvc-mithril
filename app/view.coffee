m = require 'mithril'
Link = m.route.Link

watchInput = (onenter, onescape) ->
  (e) ->
    switch e.key
      when 'Enter'
        onenter?()
        e.redraw = true
      when 'Escape'
        onescape?()
        e.redraw = true
      else
        e.redraw = false

withAttr = (callback, attr) ->
  attr = attr or 'value'
  (event) -> callback event.target[attr]

module.exports =
  headerView: (vnode) ->
    ctrl = vnode.state.ctrl

    m 'header#header', [
      m 'h1', 'todos'
      m 'input.new-todo', {
        placeholder: 'What needs to be done?'
        value: ctrl.title()
        onkeyup: watchInput ctrl.add, ctrl.clearTitle
        oninput: withAttr ctrl.title
      }
    ]

  todosView: (vnode) ->
    ctrl = vnode.state.ctrl

    m 'ul.todo-list', [
      ctrl.todos.list.filter(ctrl.isVisible).map (todo) ->
        completed = if todo.completed() then 'completed' else ''
        editing = if todo.editing() then ' editing' else ''
        save = -> ctrl.save todo
        reset = -> ctrl.reset todo

        m 'li', {class: "#{completed}#{editing}", key: todo.id}, [
          m '.view', [
            m 'input.toggle[type=checkbox]',
              onclick: withAttr(-> ctrl.toggle todo, 'checked')
              checked: todo.completed()

            m 'label', {
              ondblclick: -> ctrl.edit todo
            }, todo.title()
            m 'button.destroy', onclick: -> ctrl.remove todo
          ]

          m 'input.edit',
            value: todo.title()
            onkeyup: watchInput save, reset
            onblur: save
            oninput: withAttr todo.title
            onupdate: (vnode) -> ctrl.focus vnode, todo
        ]
    ]

  footerView: (vnode) ->
    ctrl = vnode.state.ctrl
    es = if ctrl.remaining() is 1 then '' else 's'

    m 'footer.footer', [
      m 'span.todo-count', [m('strong', ctrl.remaining()), " item#{es} left"]
      m 'ul.filters', [
        ['all', 'active', 'completed'].map (status) ->
          linkClass = if ctrl.status() is status then 'selected' else ''

          m 'li',
            m Link, {selector: "a.#{linkClass}", href: "/#{status}"},
              status

        m 'li', '🔍'

        m 'input', {
          placeholder: 'Search'
          value: ctrl.filterValue()
          onkeyup: watchInput null, ctrl.clearFilter
          oninput: withAttr ctrl.filterValue
          style: 'border: none;'
        }
      ]

      if ctrl.completed()
        m 'button.clear-completed', {onclick: ctrl.clearCompleted},
          'Clear completed'
    ]
