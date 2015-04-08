# Load express
express = require 'express'
app = express()

# Load controllers
TodosController = require '../../../controllers/api/v1/TodosController'

# Define routes
app.get '/todos', TodosController.index
app.post '/todos', TodosController.create

module.exports = app