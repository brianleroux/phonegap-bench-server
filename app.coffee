express = require 'express'
store   = require './store'
app     = module.exports = express.createServer()

app.configure ->
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

app.get '/', (req, res) ->
  res.send """
  <html>
  <body>
    <form action=/ method=post>
        <input name=platform type=text>
        <input name=device type=text>
        <input name=sha type=text>
        <input name=ms type=text>
        <input type=submit>
    </form>
  </body>
  </html>
  """

app.post '/', (req, res) ->
  store.save req.body, -> 
    res.redirect '/'

app.get '/json', (req, res) ->
  store.all (docs) ->
      res.json docs
