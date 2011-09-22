$(document).ready ->
  $('.configure-dashboard').click ->     
    $.get "dashboards/edit", (data) ->
      json_data = $.parseJSON(data)
      $dialog = $('<div></div>')
        .html(json_data.html)
        .dialog 
          autoOpen: false 
          title: json_data.title
      $dialog.dialog.open('open')
    return false