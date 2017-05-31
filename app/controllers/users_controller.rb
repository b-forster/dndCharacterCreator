get '/users' do
  erb :'users/index'
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @new_user = User.new(params[:user])
  if params[:user][:password] != params[:password_confirmation]
  @errors = ['Passwords must match.']
  erb :'users/new'
  else
    if @new_user.save
      login(@new_user)
      redirect "/users/#{current_user.id}"
    else
      @errors = @new_user.errors.full_messages
      erb :'users/new'
    end
  end
end

get '/users/:id' do
  @user = current_user
  @user_characters = @user.characters
  erb :'users/show'
end
