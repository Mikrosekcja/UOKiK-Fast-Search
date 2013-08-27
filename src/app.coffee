flatiron  = require "flatiron"
app       = flatiron.app
creamer   = require "creamer"
mongoose  = require "mongoose"

do (require "source-map-support").install

app.use flatiron.plugins.http

app.use flatiron.plugins.static,
  root: __dirname
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

app.start 1234, ->
  # TODO: configuration
  mongoose.connect ("mongodb://localhost/terms")
  console.log "Let's get abusive, yo!"
