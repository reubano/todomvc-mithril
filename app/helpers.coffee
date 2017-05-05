m = require 'mithril'
config = require 'config'

module.exports =
  watchInput: (onenter, onescape) ->
    (e) ->
      if e.keyCode is config.ENTER_KEY
        onenter()
        m.redraw.strategy('diff')
      else if e.keyCode is config.ESC_KEY
        onescape()
        m.redraw.strategy('diff')
      else
        m.redraw.strategy('none')
  store: (data) ->
    if data
      localStorage.setItem config.STORAGE_ID, JSON.stringify(data)
    else
      JSON.parse localStorage.getItem(config.STORAGE_ID) or '[]'
