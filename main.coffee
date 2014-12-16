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
      # console.log("@_id" + @_id + "isDone " + isDone)
  Template.main.helpers
    todosList: Todos.find()
    # todo: Todos.find()
    # for i in todo
    #   if i.isDone is null
    #     List.concat([i])
    #   else
    #     ListDone.concat([i])
    # todosList:List
    # todosListDone:ListDone

  Template.accountbid.events
    "click input.btn.connect": (e,t) ->
      console.log "click button"
      if Meteor.user()
        Meteor.connectWith("github")

    "click input.btn.connect.twitter": (e,t) ->
      console.log "click twitter button"
      if Meteor.user()
        Meteor.connectWith("twitter")

    "click input.btn.connect.facebook": (e,t) ->
      console.log "click facebook button"
      if Meteor.user()
        Meteor.connectWith("facebook")