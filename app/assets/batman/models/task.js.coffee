class Todo.Task extends Batman.Model
  @resourceName: 'tasks'
  @storageKey: 'tasks'

  @persist Batman.RailsStorage

  @validate "title",   presence: true

  # Use @encode to tell batman.js which properties Rails will send back with its JSON.
  @encode 'title', 'completed'
  @encodeTimestamps()
