Wadjet.controllers :main do
  
  get :index, :map => '/' do
    @dashboard = Dashboard.first(:account_id => current_account.id)         
    @widgets = Widget.fields(:name, :js, :css).all(:dashboard_id => @dashboard.id)    
    
    @widgets_js = []
    @widgets_css = []
    
    @widgets.each do |w|
      w.js.each { |j| @widgets_js << j }     
      w.css.each { |c| @widgets_css << c }
    end   
    
    @widgets = @widgets.map { |w| "'#{w.name}'" }  

    render 'main/dashboard'
  end
end