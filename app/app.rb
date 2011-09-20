require 'sinatra/flash'       
require 'padrino/sprockets'
class Wadjet < Padrino::Application
  ##
  # Initializers
  #     
  
  # Core
  register Padrino::Helpers   
  register Padrino::Rendering   
  
  # Authorizaition
  register Padrino::Admin::AccessControl 
  register Padrino::Sprockets
  register OmniAuthInitializer    
    
  # Resources. JS, CSS handling ext
  register CompassInitializer  
  register Sinatra::Flash
  
  ##
  # App Settings 
  #    
  
  # Sessions
  set :login_page, "/login"  
  set :session_id, 'widget'    
  set :asset_uri_root, "/"       

  ## 
  # Access Rules
  #                   
  
  # access_control.roles_for :any do |role|
  #   role.protect "/"
  #   role.allow "/login"
  #   role.allow "/sessions"
  # end 
  # 
  # access_control.roles_for :registered, :admin do |role|
  #   role.allow "/"
  # end  
  
  ## 
  # Error Handling
  #
  error 404 do 
    render 'errors/404'
  end     
  
  assets do    
    digest false    
    stylesheets_url 'css'
    javascripts_url 'js'  
    public_assets_folder '/'
    public_stylesheets_folder 'css'  
    public_javascripts_folder 'js'
    append_path 'assets/js'
    append_path 'assets/js/app'  
    append_path '../vendor/assets/js'
  end
end