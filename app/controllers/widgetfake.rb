Wadjet.controllers :widget_fake do  
  
  get :render_fragment, :map => '/widgets/fake/render_fragment/:slug'  do
    @widget = current_account.dashboard.widgets(:name => :fake)   
    @widget = @widget.first      
    return {:html => "bob", :slug => @widget.slug}.to_json
    #render "widgets/#{@widget.view}"
  end
end