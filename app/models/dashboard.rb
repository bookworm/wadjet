class Dashboard
  include MongoMapper::Document
  
  key :account_id, ObjectId      
  key :css,        String     
  key :grid,       String
  key :grid_class, String
    
  belongs_to :user, :class => 'Account'   
  
  def widgets(options={})
    Widget.all({:dashboard_id => self.id}.merge!(options))
  end  
  
  def add_widget(options={})   
    Widget.new({:dashboard_id => self.id}.merge!{options})
  end
  
  def remove_widget(slug) 
    widget = Widget.first(:dashboard_id => self.id, :slug => slug)       
    widget.destroy
  end
end