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
  store: (data) ->
    if data
      localStorage.setItem config.STORAGE_ID, JSON.stringify(data)
    else
      JSON.parse localStorage.getItem(config.STORAGE_ID) or '[]'
  assert: (assertion, msg) ->
    console.assert assertion, msg or ''
