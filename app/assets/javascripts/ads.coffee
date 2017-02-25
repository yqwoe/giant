# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on  ->
  $('.btn').on 'click', ->
    swal 'The Internet?', 'That thing is still around?', 'question'

  swal(
    title: 'Auto close alert!'
    text: 'I will close in 2 seconds.'
    timer: 2000).then (->
  ), (dismiss) ->
    if dismiss == 'timer'
      console.log 'I was closed by the timer'
    return
