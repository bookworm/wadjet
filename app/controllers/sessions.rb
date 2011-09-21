Wadjet.controllers :sessions do       
  
  before(:authtwitter, :authfacebook, :authgoogle) do   
    auth = params['auth']
    if authorized
      @account = Account.first(:email => auth.email)    
      if @account
        set_current_account(account)
      else   
        @account = Account.new(account_params)   
        @account.save  
        set_current_account(@account)
      end
    end   
  end  
  
  ##
  # Login and Logout 
  #       
  
  get :new, :map => '/login' do   
    render 'sessions/new'
  end
  
  post :create, :map => '/login' do
    if @account = Account.authenticate(params[:email], params[:password])
      set_current_account(@account)  
      success_resp(@account, "Logging you in") 
      redirect_back_or_default('/') 
    else     
      error_resp(@account, "E-mail or password wrong.")  
      redirect_back_or_default('/') 
    end      
  end    
  
  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect_back_or_default('/')
  end   
  
  delete :destroy do
    set_current_account(nil)
    redirect_back_or_default('/')
  end   
  
    ##
  # Omniauth Stuff
  #     
  
  get :authfail, :map => '/auth/failure' do
    auth = params['auth']
    puts auth
  end  
  
  get :authtwitter, :map => '/auth/callback/twitter' do
  end    
  
  get :authfacebook, :map => '/auth/callback/facebook' do
  end   
  
  get :authgoogle, :map => '/auth/callback/google_apps' do
  end 
end