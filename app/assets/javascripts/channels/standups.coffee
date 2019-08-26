$(document).on 'turbolinks:load', ->
  if App.standups
    App.standups.followVisibleStandups()
App.standups = App.cable.subscriptions.create "StandupsChannel",
  collection: -> $('.standup-box')

  connected: ->
    setTimeout =>
      @followVisibleStandups()
    , 1000


  followVisibleStandups: ->
    standups = @collection().map(-> $(@).attr('data-standup')).get()
    if standups.length > 0
      for standup in standups
        @perform 'follow', standup_id: standup
    else
      @perform 'unfollow'

  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    console.log "[ActionCable] [Standup] [#{data.id}] [#{data.action}]", data
    box = $(".standup-box[data-standup='#{data.id}']")
    if box
      box.find('.box-body').first().replaceWith(data.html)
