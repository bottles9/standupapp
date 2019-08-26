$(document).on 'turbolinks:load', ->
  $(document).on 'click', '.notifications-menu .dropdown-toggle', ->
   $('.notifications-menu .dropdown-toggle .label-warning').hide()
App.userNotifications = App.cable.subscriptions.create "WebNotificationsChannel",
  box: -> $('#notification-container')

  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    console.log "[ActionCable] [Notification]", data
    @box().first().html(data.html)
    @box().first().parent().find('.label-warning').show()