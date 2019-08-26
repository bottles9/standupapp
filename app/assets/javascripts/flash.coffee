$(document).on 'turbolinks:load', ->
  $('.alert:not(.alert-fixed)').delay(5000).slideUp 500, ->
    $('.alert').alert 'close'
