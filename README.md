PhoneGap/Bench
===

Benchmarking suite for PhoneGap.

Summary
---

This is a simple app to provide persistence to benchmarks obtained from a test application for PhoneGap. Presumably, we will moniter and use the data obtained to improve PhoneGap initialization performance.

Server Impl
---

The server portion of this application provides a simple REST API for persisting data obtained from the client application. Currently the app is deployed on Heroku, implemented in NodeJS, CoffeeScript and MongoDB. If you want to hack on it and deploy it to the main site just ping @brianleroux for collaborator access on Heroku.

Client Impl
---

The `www` folder contains a basic PhoneGap application that will load up and send its results to the server implementation. There is some automation in creating and deploying this application from PhoneGap/Android.


