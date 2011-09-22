Wadjet.controllers :dashboards do   
  
  before(:add_widget, :remove_widget, :show, :edit) do    
    @dashboard = Dashboard.first(:slug => params[:slug], :account_id => current_account.id)
  end   
  
  before(:index) do
    @dashboard = Dashboard.first(:account_id => current_account.id, :main => true)          
  end
  
  before(:index, :show) do
    @widgets = Widget.fields(:slug, :js, :name, :css, :refresh).all(:dashboard_id => @dashboard.id)    
    
    @widgets_js = []
    @widgets_css = []

    @widgets.each do |w|
      w.js.each { |j| @widgets_js << '/js/widgets/' + j }
      w.css.each { |c| @widgets_css << '/css/widgets/' + c }
    end  
    
    @widgets = @widgets.map { |w| { :slug => w.slug, :refresh => w.refresh, :name => w.name} }  
  end  
  
  before(:create, :edit) do 
    @grids = Grid.all( :order => "title desc").map { |grid| [grid.title, grid.id] }     
  end    
  
  before(:new) do
    @selected_grid = @grids.first.id  
  end
  
  before(:edit) do
    @selected_grid = @dashboard.grid().id
  end
  
  get :index, :map => '/' do
    render 'dashboards/show'
  end  
  
  get :show, :map => '/dashboards/:slug' do 
    render 'dashboards/show' 
  end  
  
  get :new, :map => '/dashboards/new' do          
  end
   
  post :create, :map => '/dashboards' do
    @dashboard = Dashboard.new({:account_id => current_account.id}.merge!(params[:dashboard]))
    if @dashboard.save
      return 200
    else
      return halt 400, @dashboard.errors.to_json
    end
  end
  
  post :add_widget, :map => '/dashboards/:slug/widgets/add' do
    @widget = dashboard.add_widget(params[:settings])
    if @widget.save
      return 200
    else
      return halt 400, @widget.errors.to_json
    end
  end  
  
  get :remove_widget, :map => '/dashboards/:slug/widgets/:widget_slug/remove' do    
    if @dashboard.remove_widget(params[:widget_slug])
      return 200
    else
      return halt 400, @widget.errors.to_json
    end
  end
end