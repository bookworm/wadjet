Wadjet.controllers :dashboard do   
  
  before (:add_widget, :remove_widget, :show) do    
    @dashboard = Dashboard.first(:slug => params[:slug], :account_id => current_account.id)
  end
  
  before(:index, :show) do
    @widgets = Widget.fields(:name, :js, :css).all(:dashboard_id => @dashboard.id)    
    
    @widgets_js = []
    @widgets_css = []
    
    @widgets.each do |w|
      w.js.each { |j| @widgets_js << j }     
      w.css.each { |c| @widgets_css << c }
    end   
    
    @widgets = @widgets.map { |w| "'#{w.name}'" }  
  end
  
  get :index, :map => '/' do
    @dashboard = Dashboard.first(:account_id => current_account.id)         
    render 'dashboards/show'
  end  
  
  get :show, :map => '/dashboards/:slug' do 
    render 'dashboards/show' 
  end
  
  post :add_widget, :map => '/dashboards/:slug/add_widget' do
    @widget = dashboard.add_widget(params[:settings])
    if @widget.save
      return 200
    else
      return halt 400, @widget.errors.to_json
    end
  end  
  
  get :remove_widget, :map => '/dashboards/:slug/remove_widget/:widget_slug' do    
    if @dashboard.remove_widget(params[:widget_slug])
      return 200
    else
      return halt 400, @widget.errors.to_json
    end
  end
end