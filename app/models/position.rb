class Position
  include MongoMapper::EmbeddedDocument
  
  key :left, Float
  key :top,  Float
end