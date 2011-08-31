MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'wadjet_development'
  when :production  then MongoMapper.database = 'wadjet_production'
  when :test        then MongoMapper.database = 'wadjet_test'
end
