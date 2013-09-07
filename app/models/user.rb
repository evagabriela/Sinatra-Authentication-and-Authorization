class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users

  validates :email, :presence => true, 
                       :uniqueness => true
  validates :password, :presence => true
    include BCrypt

  def password 
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password ||= Password.create(pass)
    self.password_hash = @password
  end

  #remember how we redefined User.create before? That gets a modification as well:

  def self.create(params)
    user = User.new(
      :name => params[:name],
      :email => params[:email] )
    user.password = params[:password]
    user.save
    user
  end  

  def self.authenticate(email,password)
    user = User.find_by_email(email)
    (user && user.password == password) ? user : nil
  end
end

