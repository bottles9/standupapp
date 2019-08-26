$(document).on 'turbolinks:load', ->
  if App.teamStandups
    App.teamStandups.followTeamStandups()
App.teamStandups = App.cable.subscriptions.create "TeamStandupsChannel",
  box: -> $('#team-standups-container')

  connected: ->
    setTimeout =>
      @followTeamStandups()
    , 1000


  followTeamStandups: ->
    if @box().length > 0
      date = @getDate()
      @perform 'follow',
        team_id: window.location.pathname.split("/")[2],
        date: date
    else
      @perform 'unfollow'


  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    console.log "[ActionCable] [Standup]", data
    @box().first().replaceWith(data.html)

  getDate: ->
    if window.location.pathname.split("/")[4]
      window.location.pathname.split("/")[4]
    else
      new Date().toISOString().substring(0, 10)
