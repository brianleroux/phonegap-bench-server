s = require './../store'

s.nuke ->
  s.save {a:1}, ->
    s.all console.log
