mongoose = require 'mongoose'

controller =
	index: (req, res) ->
		Todo = mongoose.model 'Todo'
		Todo.find active: true, (err, todos) ->
			if err?
				res.status 500
				return

			_todos = []
			for todo in todos
				do (todo) ->
					_todos.push
						_id: todo._id
						contents: todo.contents
						done: todo.done

			res.json todos: _todos

	create: (req, res) ->
		if req.body.todo?
			req.body.contents = req.body.todo.contents

		req.checkBody('contents', 'Invalid todo contents').notEmpty()

		errors = req.validationErrors()

		if errors
			res.status 400
			res.json errors
			return

		Todo = mongoose.model 'Todo'
		todo = new Todo
			contents: req.body.contents
			done: false

		todo.save (err, todo) ->
			if err?
				res.status 500
				res.end()
			else
				res.json
					todo:
						_id: todo._id
						contents: todo.contents
						done: false


module.exports = controller;