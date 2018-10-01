m = require 'mithril'
Controller = require 'controllers/site-controller'
view = require 'views/main-view'

module.exports = class Component
  oninit: (vnode) ->
    vnode.state.ctrl = new Controller vnode.attrs

  onbeforeupdate: (vnode) ->
    vnode.state.ctrl.update vnode.attrs

  view: view
