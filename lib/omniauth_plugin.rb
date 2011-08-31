##
# Authentication Plugin via omniauth on Padrino
# prereqs:
# http://github.com/intridea/omniauth/
# http://github.com/achiu/omniauth/ working fork
#    

module OmniAuthInitializer
  def self.registered(app)    
    require 'omniauth'
    
    app.use OmniAuth::Builder do  
      # provider :password
      # provider :twitter, 'consumer_key', 'consumer_secret'
      # provider :facebook, 'app_id', 'app_secret'
    end    
  end                           
end