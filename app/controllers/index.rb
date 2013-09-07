get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
    if user = User.authenticate(params[:email], params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.messages
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  session[:user_id] = nil
 
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    @error = user.errors.messages
    erb :index
  end
end
