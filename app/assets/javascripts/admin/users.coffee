# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.car-modify').on 'click', ->
    id = $(this).data('id')
    licensed_id = $('#licensed-' + id).val()
    valid_at = $('#valid-' + id).val()
    data = car:
      id: id,
      licensed_id: licensed_id
      valid_at: valid_at
    $.ajax
       url: '/admin/cars/' + id
       type: 'PUT'
       data: data
       success: (data) ->
         console.log  data

  $('.car-delete').on 'click', ->
    id = $(this).data('id')
    record = $('#car-' + id)
    $.ajax
      url: '/admin/cars/' + id
      type: 'DELETE'
      success: (data) ->
        alert data.licensed_id + '已经从数据库中删除'
        record.remove()
     fail: (data) ->
       alert data.message
