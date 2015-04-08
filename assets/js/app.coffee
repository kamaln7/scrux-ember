App = Ember.Application.create
	rootElement: '#app'

App.Adapter = DS.RESTAdapter.extend
	serializer: DS.RESTSerializer.extend
		primaryKey: -> '_id'

App.Store = DS.Store.extend({
	revision: 12,
	adapter: 'App.Adapter'
});

DS.RESTAdapter.reopen({
	namespace: 'api/v1'
});

App.Todo = DS.Model.extend
	contents: DS.attr 'string'
	done: DS.attr 'boolean'

###todos = [{
	id: 1
	contents: 'Do stuff'
	done: false
}, {
	id: 2
	contents: 'Buy milk'
	done: true
}]###

App.Router.map ->
	@resource 'about'
	@resource 'todos', ->
		@resource 'todo', path: ':todo_id'
		true
	true

App.IndexRoute = Ember.Route.extend
	redirect: ->
		@transitionTo 'about'

App.TodosRoute = Ember.Route.extend

	setupController: () ->
		todos = App.Todo.find()
		todos.on 'didLoad', ->
			console.log ' +++ Todos loaded'

		@controllerFor('todos').set 'model', todos

App.TodosController = Ember.Controller.extend
	actions:
		createTodo: ->
			contents = @get('newContents').trim()
			if not contents then return

			todo = @store.createRecord 'todo',
				contents: contents

			todo.save()

###App.TodoRoute = Ember.Route.extend
	model: (params) ->
		todos.findBy '_id', params.todo_id###