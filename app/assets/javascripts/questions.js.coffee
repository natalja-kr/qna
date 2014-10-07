# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.edit-answer-link').click ->
    id = $(this).data('answerid');
    $('#edit-answer-'+id).show();
    return false;

