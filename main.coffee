@Todos = new Meteor.Collection "todos"

Todos.allow
  remove: ->
    true

  update: ->
    true

Meteor.methods
  addTodo: (title) ->
    Todos.insert "title": title

if Meteor.isServer
  Meteor.publish "todos", ->
    Todos.find()

if Meteor.isClient
  Meteor.subscribe "todos"

  Template.main.events
    "click #add-todo": ->
      todoText = $("#input-todo").val()

      if todoText.trim() isnt ""
        Meteor.call "addTodo", todoText, (err, res) ->
          $('#input-todo').val ""
          if not err
            console.log "res = "
            console.log res

          else
            console.log "err = "
            console.log err


    'click .delet-todo': (e, t)->
      Todos.remove @_id

    'change .todo-done': (e, t) ->
      isDone = $(e.target).is(':checked')
      Todos.update
        _id: @_id
      ,
        $set:
          isDone: isDone

  Template.main.helpers
    todosList: Todos.find()
    checkedstate: (if @isDone then "checked" else "")

  # Template.main.helpers
  #   # checkedstate: (if @isDone then "checked" else "")
  #   todosList = Todos.find
  #   console.log(Todos.find())