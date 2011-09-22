Wadjet.controllers :widgets do
  
  post :save_position, :map => '/widgets/:slug/save_position/' do
    @widget = Widget.first(:slug => params[:slug])   
    @widget.position.update_attributes(params[:position])    
    if @widget.save
      return 200
    else
      return halt 400, @widget.errors.to_json
    end
  end   
  
  post :settings, :map => '/widgets/:slug/settings/' do        
    @widget = Widget.first(:slug => params[:slug])   
    if @widget.update_attributes(params[:settings])     
      return 200
    else
      return halt 400, @widget.errors.to_json
    end
  end  
end 