express = require 'express'
app = module.exports = express.createServer express.logger()

app.get '/', (req, res) ->
  res.send 'Hello World!'
