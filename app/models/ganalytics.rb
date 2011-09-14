require 'garb'
class Ganalytics < Widget       
  extend Garb::Model

  metrics :exits, :pageviews
  dimensions :page_path
                       
  # TODO: use oauth instead
  key :username, String
  key :password, String 
  
  def initialize()
    self.name = 'ganalytics'
  end
end