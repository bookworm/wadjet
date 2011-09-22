//= require jquery
//= require jquery.ui
//= require jquery.dotimeout
//= require jquery.ujs
//= requre spin
//= require jquery.spin
$(document).ready(function() {      
  $.each(widgets, function(index, value) {   
    $.get('widgets/' + value.name + '/' + 'render_fragment/' + value.slug, function(data) {  
      var json_data = $.parseJSON(data);     
      var $widget = $('<div></div>')
        .attr('id', 'widget'+'-'+value.slug)
        .html(json_data.html);
      $('#widgets').append($widget);
    });
  }); 
  
  $.doTimeout(5000, function(){    
    $.each(widgets, function(index, value) {  
      if(value.refresh == true)  
      {    
        var spinner = $('#widget-'+value.slug).spin();   
        $.get('widgets/' + value.name + '/' + 'render_fragment/' + value.slug, function(data) {  
          var json_data = $.parseJSON(data);      
          spinner.stop;                    
          $('#widget-'+value.slug).html(json_data.html);
        });
      }
    });
  });  
  
  $('#widgets .widget').draggable({ 
    containment: 'parent',
    cursor: 'move',
    stop: function(event, ui) {     
      var widget_id = $(this).attr('widgetid');
      $.post('widgets/save_position/'+ widget_id, { 
        'position': { 
          'top': ui.offset.top, 
          'left': ui.offset.left       
        } 
      }); 
    }
  }); 
  
  $('.configure-widget').click(function() {     
    var widget_id = $(this).parent().parent().attr('widgetid');
    $.get('widgets/settings/' + widget_id, function(data) { 
      var json_data = $.parseJSON(data);    
      
      var $dialog = $('<div></div>')
        .html(json_data.html)
        .dialog({
          autoOpen: false,
          title: json_data.titles
        });    
        
      $dialog.dialog('open');
    });
  });
  
  $('.settings-form').live('ajax:failure', function(event, xhr, status) {
    var response = $.parseJSON(xhr.responseText);    

    if($.isPlainObject(response))
    {      
      if(response.errors) {
        $(this).data().validator.showErrors(response.errors);
      }
      else {
        $(this).data().validator.showErrors({"email": response.message});
      }
    }      
  });  
  
  $('.setings-form').live('ajax:success', function(event, xhr, status) {      
    var response = $.parseJSON(xhr.responseText);           
    $(this).parent('.dialog').close();
  });     
  
  $('.cancel').click(function() {
    $(this).parent('.dialog').close();
  });
});