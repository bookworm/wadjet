class Widget
  include MongoMapper::Document

  key :dashboard_id, ObjectId    
  key :view,         String
  key :name,         String
  key :title,        String
  key :desc,         String   
  key :js,           Array
  key :css,          Array 
end