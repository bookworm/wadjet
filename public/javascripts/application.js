$(document).ready(function() {      
  $.each(widgets, function(index, value) {   
    $.get('widgets/' + value + '/render_fragment/', function(data) {
      $('#widgets').append(data);
    });
  });
});
