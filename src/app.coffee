flatiron  = require "flatiron"
app       = flatiron.app

app.use flatiron.plugins.http

app.router.get '/', ->
  @res.writeHead 200, "Content-type": "text/plain"
  @res.end "UOKiK Fast Search and Classification Engine"

app.start 1234