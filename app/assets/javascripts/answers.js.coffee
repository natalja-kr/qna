# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#ready = ->
#  jQuery ->
#    $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
#      answer = $.parseJSON(xhr.responseText);
#      $('.answers').append('<p>' + answer.body + '</p>');
#
#    $('form.new_answer').bind 'ajax:error', (e, xhr, status, error) ->
#      errors = $.parseJSON(xhr.responseText);
#      $.each errors, (index, value) ->
#        $('.answer-errors').append(value);
ready = ->
  jQuery ->
    questionId = $('.answers').data('questionId');
    channel = '/questions/' + questionId + '/answers'
    PrivatePub.subscribe channel, (data, channel) ->
      console.log(data)
      answer = $.parseJSON(data['answer'])
      $('.answers').append('<p>' + answer.body + '</p>')
      $('.answers').append('<p><a href="#">Edit</a></p>')
      $('.new_answer #answer_body').val('');

$(document).ready(ready)
$(document).on('page:load', ready)