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


    'click .btn.btn-mini.delete-todo': (e, t)->
      Todos.remove @_id

    'change .todo-done': (e, t) ->
      isDone = $(e.target).is(':checked')
      Todos.update
        _id: @_id
      ,
        $set:
          isDone: isDone
      console.log("@_id" + @_id + "isDone " + isDone)
  Template.main.helpers
    todosList: Todos.find()
    # for i in Todos.find()
    #   console.log(i.title)
    #   if i.isDone == true
    #     i.checked= "checked"