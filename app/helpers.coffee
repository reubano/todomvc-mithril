m = require 'mithril'
config = require 'config'

module.exports =
  watchInput: (onenter, onescape) ->
    (e) ->
      if e.keyCode is config.ENTER_KEY
        onenter()
        e.redraw = true
      else if e.keyCode is config.ESC_KEY
        onescape()
        e.redraw = true
      else
        e.redraw = false
  store: (data) ->
    if data
      localStorage.setItem config.STORAGE_ID, JSON.stringify(data)
    else
      JSON.parse localStorage.getItem(config.STORAGE_ID) or '[]'
  filter: (array, predicate, reverse) ->
    if reverse
      (value for value in array when not predicate value)
    else
      (value for value in array when predicate value)
  assert: (assertion, msg) ->
    console.assert assertion, msg or ''

