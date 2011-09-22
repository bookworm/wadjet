class Dashboard
  include MongoMapper::Document
  
  key :title, String
  key :account_id, ObjectId      
  key :css,        String     
  key :grid_id,    ObjectId
    
  belongs_to :user, :class => 'Account'   
        
  def grid()
    Grid.first(:id => self.grid_id) 
  end        
  
  def grid=(grid)
    self[:grid_id] = grid if grid.is_a?(BSON::ObjectId)    
    self[:grid_id] = grid.id if grid.is_a?(Grid)
  end
  
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