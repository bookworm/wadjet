$(document).reader ->
  $.each widgets, (index, widget) ->    
    $.get "widgets/#{widget.name}/#{widget.slug}", (data) ->
      json_data = $.parseJSON(data)
      $widget = $('<div></div>')
        .attr('id', "widget-#{widget.slug}")       
        .addClass('widget')
        .html(json_data.html)
      $('#widgets').append($widget)    
       
  $.doTimeout 500000, ->
    $.each widgets, (index, widget) ->  
      if widget.refresh  
        spinner = $("#widget-#{widget.slug}").spin
        $.get "widgets/#{widget.name}/#{widget.slug}", (data) ->
          json_data = $.parseJSON(data)
          spinner.stop
          $("#widget-#{widget.slug}").html(json_data.html)  
    return true
    
  $('#widgets .widget').draggable ->
    containment: 'parent'
    cursor: 'move'
    stop: (event, ui) ->
      widget_slug = $(@).attr('id')
      widget_slug = gsub(widget_slug, 'widget-', '')  
      console.log(widget_slug)
      $.post("widgets/#{widget_slug}/save_position")
        position:
          top: ui.offset.top
          left: ui.offset.left
             
  $('.configure-widget').click ->
    widget_slug = $(this).parent('.widget').attr('id')   
    $.get "widgets/#{widget.name}/#{widget.slug}/edit", (data) ->
      json_data = $.parseJSON(data)
      $dialog = $('<div></div>')
        .html(json_data.html)
        .dialog 
          autoOpen: false 
          title: json_data.title
      $dialog.dialog.open('open')  
         
  $('.add-widget').click ->     
    $.get "widgets/new", (data) ->
      json_data = $.parseJSON(data)
      $dialog = $('<div></div>')
        .html(json_data.html)
        .dialog 
          autoOpen: false 
          title: json_data.title
      $dialog.dialog.open('open')
    return false