require 'digest/sha1'     
require 'bcrypt'
class Account
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Timestamps        
  attr_accessor :password, :password_confirmation, :role

  # Keys
  key :first_name,       String  
  key :last_name,        String
  key :username,         String
  key :email,            String
  key :crypted_password, String
  key :salt,             String
  key :roles,            Array, :default => [:registered]    
  key :purchases,        Array 
  key :reset_code,       String
  
  # Key Settings        
  timestamps!   
  
  # Validations
  validates_presence_of     :email, :roles
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i      
  validates_uniqueness_of   :username
  
  # Callbacks
  before_save :encrypt_password, :if => :password_required  
                      
  ### 
  # Getters and Setters        
  #
  
  ## Getters  
  def name()  
    return "#{self[:first_name]}, #{self[:last_name]}"
  end  
  
  def dashboard()
    Dashboard.first(:account_id => self.id)
  end    
  
  def dashboards()
    Dashboard.all(:account_id => self.id)
  end
  
  ## 
  # Auth methods
  #
  
  def self.authenticate(email, password)
    account = first(:email => email) if email.present?
    account && account.has_password?(password) ? account : nil
  end
  
  def roles=(t)
    if t.kind_of?(String)
      t = t.downcase.split(",").join(" ").split(" ").uniq
    end
    self[:roles] = t
  end     
  
  def role=(role)
    self.roles << role if !self.roles.include?(role)
  end
 
  def has_role?(role)     
    return self.roles.include?(role)
  end      
  
  def has_details?()
    if self[:last_name] || self[:first_name] || self[:username]
      return true
    else 
      return false
    end
  end    
  
  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end   
  
  def newpass(len=9)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    self.password = newpass
    self.encrypt_password
  end

  private 
    def encrypt_password
      self.crypted_password = ::BCrypt::Password.create(password)
    end      
    def password_required
      crypted_password.blank? || password.present?
    end      
end