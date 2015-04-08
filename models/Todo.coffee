mongoose = require 'mongoose'
troop = require 'mongoose-troop'

TodoSchema = new mongoose.Schema
	user_id: mongoose.Schema.ObjectId
	contents: String
	done: Boolean
	active:
		type: Boolean
		default: true

TodoSchema.plugin troop.timestamp

Todo = mongoose.model 'Todo', TodoSchema

module.exports = Todo