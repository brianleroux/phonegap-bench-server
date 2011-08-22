store = require './store'
guid = -> 
    s4 = -> (((1+Math.random())*0x10000)|0).toString(16).substring(1)
    s4()+s4() +"-"+ s4() +"-"+ s4() +"-"+ s4() +"-"+ s4()+s4()+s4()

for i in [0..10]
    r = 
        report:'phonegap-android-init'
        sha:'asdf'
        platform:'android'
        name:'nexus s'
        ms:Math.random()*1000
    #, created:((new Date()).toUTCString())
    #console.log r
    store.save r
