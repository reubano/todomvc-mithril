m = require 'mithril'
config = require 'config'

module.exports =
  watchInput: (onenter, onescape) ->
    (e) ->
      switch e.key
        when 'Enter'
          onenter()
          e.redraw = true
        when 'Escape'
          onescape()
          e.redraw = true
        else
          e.redraw = false
