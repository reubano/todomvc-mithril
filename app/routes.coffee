m = require 'mithril'

module.exports = (app) ->
  '/': render: (vnode) -> m app, vnode.attrs
  '/:status': render: (vnode) -> m app, vnode.attrs
  # '/': app
  # '/:status': app
