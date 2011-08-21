redis = require 'redis'

# obviously this is not really secure!
auth = (cb) ->
  client = redis.createClient 9031, 'carp.redistogo.com', {}
  client.auth '42eb2acff719dafafd30afe52f0e6e00', ->
    cb(client)

# save a document
exports.save = (doc, cb) ->
    val = JSON.stringify doc
    key = require('crypto').createHash('sha1').update(val).digest('hex')
    auth (client) ->
        client.hset 'reports', key, val, (err, reply) ->
            cb()
            client.end()

exports.nuke = (cb) ->
    auth (client) ->
        client.flushdb()
        cb()
        client.end()

exports.all = (cb) ->
    auth (client) ->
        # could do hvals but might want to do something w/ that key eventually...
        client.hgetall 'reports', (err, replies) ->
            records = (JSON.parse(val) for key, val of replies)
            cb(records) unless err
            client.end()
