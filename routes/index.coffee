# Load express
express = require 'express'
app = express()

# Load middlewares
middlewares = require './middlewares'

# Load controllers
HomeController = require '../controllers/HomeController'

# Define routes
# Home
app.get '/', HomeController.getIndex

# Load API routes
app.use '/api/v1', require './api/v1'

module.exports = app