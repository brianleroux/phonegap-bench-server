s = require './../store'

exports['sanity'] = (test) ->
    test.expect 1
    test.ok true, 'this is truthy'
    test.done()

exports['save'] = (test) ->
    test.expect 1
    s.save report:'testing', a:1, ->
        s.all (docs) ->
            console.log docs
            test.equals docs.length, 1, 'there is one doc'
            test.done()

exports['all'] = (test) ->
    test.expect 1
    s.all (docs) ->
        test.ok docs, 'docs array exists'
        test.done()

exports['reports'] = (test) ->
    test.expect 1
    s.save report:'testing', a:1, ->
        s.save report:'testing', a:2, ->
            s.save report:'testing2', a:1, ->
                s.all (reports) ->
                    console.log reports
                    test.ok reports, 'reports returned'
                    test.done()

exports['nuke'] = (test) ->
    test.expect 1
    s.nuke ->
        s.all (docs) ->
            test.equal docs.length, 0, 'nuke removed all docs'
            test.done()
