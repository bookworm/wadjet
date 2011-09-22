Wadjet.controllers :widget_fake do  
  
  get :render, :map => '/widgets/fake/:slug'  do
    @widget = current_account.dashboard.widgets(:name => :fake)   
    @widget = @widget.first
    html = render "widgets/#{@widget.view}"      
    {:html => html, :slug => @widget.slug}.to_json
  end
end