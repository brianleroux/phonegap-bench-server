redis = require 'redis'

# obviously this is not really secure!
# the data stored in this redis instance is of no consequence 
# ...or the 'your data is boring' theory
auth = (cb) ->
  client = redis.createClient 9031, 'carp.redistogo.com', {}
  client.auth '42eb2acff719dafafd30afe52f0e6e00', ->
    cb(client)

# assumes a report schema to =
#
#   report:   'phonegap-android-init' <--- alpha numeric: no spaces/newlines
#   sha:      'sha of the phonegap commit'
#   platform: 'maps to device.platform'
#   name:     'maps to device.name'
#   ms:       'total time in ms'
#   created:  'date/time of the report generation'
#
exports.save = (doc, cb) ->
  val = JSON.stringify doc
  key = require('crypto').createHash('sha1').update(val).digest('hex')
  auth (client) ->
    client.hset doc.report, key, val, (err, reply) ->
      cb()
      client.end()

exports.nuke = (cb) ->
  auth (client) ->
    client.keys '*', (err, replies) ->
      client.del replies, (err, reply) ->
        cb(reply)
        client.end()

exports.all = (cb) ->
  auth (client) ->
    client.keys '*', (err, platforms) ->
        commands = (['hvals', key] for key in platforms)
        client.multi(commands).exec (err, replies) ->
            reports = ((JSON.parse(r) for r in report) for report in replies)
            cb reports unless err
            client.end()
