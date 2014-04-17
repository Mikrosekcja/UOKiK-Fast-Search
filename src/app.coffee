do (require "source-map-support").install

flatiron  = require "flatiron"
app       = flatiron.app
creamer   = require "creamer"


app.use flatiron.plugins.http

app.use flatiron.plugins.static,
  dir: "assets/scripts/app/"
  url: "/js"

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

app.start process.env.PORT or 1234, ->
  # TODO: configuration
  console.log "Let's get abusive, yo!"
