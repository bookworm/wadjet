$(document).ready ->
  $('.configure-dashboard').click ->     
    widget_slug = $(this).parent('.widget').attr('id')   
    $.get "widgets/#{widget.name}/add/#{widget.slug}", (data) ->
      json_data = $.parseJSON(data)
      $dialog = $('<div></div>')
        .html(json_data.html)
        .dialog 
          autoOpen: false 
          title: json_data.title
      $dialog.dialog.open('open')
    return false