class Size
  include MongoMapper::EmbeddedDocument
  
  key :width,  String # width in columns.
  key :height, String # height in columns
end