flatiron  = require "flatiron"
app       = flatiron.app
creamer   = require "creamer"

[]
app.use flatiron.plugins.http
app.use creamer,
  layout      : require "./views/layout"
  views       : __dirname + '/views'
  # helpers     : __dirname + '/views/helpers'
  controllers : __dirname + '/controllers'
  attach      : (data) ->
    # $ "running creamer attach"
    # data.i18n     = i18n
    data.version  = (require "../package.json").version
    # data.marked   = marked

app.start 1234