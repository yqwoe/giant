# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.car-modify').on 'click', ->
    id = $(this).data('id')
    licensed_id = $('#licensed-' + id).val()
    data = {cars: {id: id, licensed_id: licensed_id}}
    $.ajax
       url: '/admin/cars/' + id
       type: 'PUT'
       data:
         licensed_id: licensed_id
       success: (data) ->
         console.log  data
