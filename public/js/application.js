$(document).ready(function() {      
  $.each(widgets, function(index, value) {   
    $.get('widgets/render_fragment/' + value, function(data) {
      $('#widgets').append(data);
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
});