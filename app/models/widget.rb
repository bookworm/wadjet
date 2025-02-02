class Widget
  include MongoMapper::Document 
  include MongoMapperExt::Slugizer
                     
  key :dashboard_id, ObjectId    
  key :view,         String
  key :name,         String
  key :title,        String
  key :desc,         String   
  key :js,           Array
  key :css,          Array   
  key :refresh,      Boolean, :default => true
  key :size,         Size
  
  slug_key :name    
  
  def dashboard=(dashboard)
    self[:dashboard_id] = dashboard if dashboard.is_a?(BSON::ObjectId)    
    self[:dashboard_id] = dashboard.id if dashboard.is_a?(Dashboard)
  end
  
  def generate_slug()    
    return false if self[self.class.slug_key].blank?
    max_length = self.class.slug_options[:max_length]
    min_length = self.class.slug_options[:min_length] || 0

    slug = self[self.class.slug_key].parameterize.to_s
    slug = slug[0, max_length] if max_length

    if slug.size < min_length
      slug = nil
    end

    key = UUIDTools::UUID.random_create.hexdigest[0,2] #optimize
    self.slug = key+"-"+slug    
  end
end