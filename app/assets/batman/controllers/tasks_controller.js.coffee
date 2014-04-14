class Todo.TasksController extends Todo.ApplicationController
  routingKey: 'tasks'

  index: (params) ->
    @set('tasks', Todo.Task.get('all'))

  edit: (params) ->
    Todo.Task.find params.id, @errorHandler (task) =>
      @set('task', task)

  new: (params) ->
    @set('task', new Todo.Task)

  create: (params) ->
    @task.save (err, task) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect '/tasks'

  update: (params) ->
    @task.save (err, task) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect '/tasks'

  destroy: (node, event, context) ->
    task = if context.get('task') then context.get('task') else @task
    task.destroy (err) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect '/tasks'
