$(document).on 'turbolinks:load', ->
  if App.userStandups
    App.userStandups.followUserStandups()
App.userStandups = App.cable.subscriptions.create "UserStandupsChannel",
  box: -> $('#user-standups-container')

  connected: ->
    setTimeout =>
      @followUserStandups()
    , 1000


  followUserStandups: ->
    if @box().length > 0
      @perform 'follow', user_id: window.location.pathname.split("/")[3]
    else
      @perform 'unfollow'


  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    console.log "[ActionCable] [Standup] [#{data.id}] [#{data.action}]", data
    @box().first().replaceWith(data.html)
