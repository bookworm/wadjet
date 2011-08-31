class Dashboard
  include MongoMapper::Document
  
  key :account_id, ObjectId      
  key :css,        String
    
  belongs_to :user, :class => 'Account'   
  
  def widgets(options={})
    Widget.all({:dashboard_id => self.id}.merge!(options))
  end
end