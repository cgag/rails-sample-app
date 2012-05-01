# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('textarea').bind('keyup', ->
    count = @value.length
    remaining = 140 - count
    $('#char').text(remaining.toString() + " Charcater remaining")
    if remaining >= 0
      $('#char').attr('class', 'alert-success')
    else
      $('#char').attr('class', 'alert-error'))
