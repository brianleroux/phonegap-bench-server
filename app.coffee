express = require 'express'
store   = require './store'
app     = module.exports = express.createServer()

app.configure ->
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + '/public')
  app.use app.router

# homepage displays reports dynamically
app.get '/', (req, res) ->
  title = 'PhoneGap/Bench'
  res.send """
    <html>
    <head>
      <title>#{ title }</title>
    </head>
    <body>
      <h1>#{ title }</h1>
      <form action=/ method=post>
      <input name=_method type=hidden value=delete>
      <input type=submit value=clobber the report data>
      </form>
      <div id=chart_div></div>
      <script src=http://xuijs.com/downloads/xui-2.2.0.min.js></script>
      <script src=https://www.google.com/jsapi></script>
      <script src=/app.js></script>
    </body>
    </html>
  """

# get all benchmark data as json
app.get '/reports.json', (req, res) ->
  store.all (docs) -> 
    res.json docs

# save a benchmark
app.post '/', (req, res) ->
  store.save req.body, -> 
    res.redirect '/'

# clear the data
app.del '/', (req, res) ->
  store.nuke ->
    res.redirect '/'
