class Grid
  include MongoMapper::Document
  
  key :name,      String
  key :title,     String
  key :js,        Array
  key :css,       Array    
  key :css_class, String 
end