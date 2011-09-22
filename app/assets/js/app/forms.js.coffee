$(document).reader ->
  $('.settings-form').live 'ajax:failure', (event, xhr, status) ->    
    response = $.parseJSON(xhr.responseText) 
    if $.isPlainObject(response)     
      if response.errors
        $(@).data.validator.showErrors(response.errors)   
      else
        $(@).validator.showErrors("email": response.message)      
        
  $('.settings-form').live 'ajax:success', (event, xhr, status) ->  
    response = $.parseJSON(xhr.responseText)           
    $(@).parent('.dialog').close()
                                            
  $('.cancel').click ->
    $(@).parent('.dialog').close()                                       
                                           