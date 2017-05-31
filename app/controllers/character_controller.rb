before do
  # find_by_user_id_and_project_id(params[:user_id],params[:project_id])
  # @character = find_by()
end

get '/users/:user_id/characters' do
  erb :'characters/index'
end

get '/users/:user_id/characters/new' do
  if request.xhr?

    @race = params["race"]

    @api = HTTParty.get("http://5e-api.com/v1/races/#{@race}")

    @racial_bonuses_array = @api[0]["racial_bonus"]
    @racial_bonuses_hash = Hash.new
    @racial_bonuses_array.each {|hash| @racial_bonuses_hash[hash["name"]] = hash["bonus"]}
    @racial_bonuses_hash.to_json
  else
    erb :'/characters/new'
  end
end

get '/users/:user_id/characters/new/roll' do
  if request.xhr?
    stat_roll.to_s
  else
    erb :'/characters/new'
  end
end

post '/users/:user_id/characters' do
  @character = Character.new(params[:character])
  @character.user_id = current_user.id

  if @character.valid?

    @race = @character.race

    @api = HTTParty.get("http://5e-api.com/v1/races/#{@race}")

    @racial_bonuses_array = @api[0]["racial_bonus"]
    @racial_bonuses_hash = Hash.new

    @racial_bonuses_array.each do |hash|
      @racial_bonuses_hash[hash["name"]] = hash["bonus"]
    end

    @racial_bonuses_hash.each do |key, value|
      stat = key.downcase.to_s
      @character[stat] += value
    end
    if @character.save
      redirect "/users/#{current_user.id}"
    else
      @errors = @character.errors.full_messages
      erb :'/characters/new'
    end
  else
    @errors = @character.errors.full_messages
    erb :'/characters/new'
  end
end

get '/users/:user_id/characters/:id' do
  @character = Character.find(params[:id])
  @user = User.find(params[:user_id])

  char_class = @character.character_class

  class_img_hash = {
      'Barbarian' => "/images/Barb.jpg",
      'Bard' => "/images/Bard.jpg",
      'Cleric' => "/images/cleric.jpg",
      'Druid' => "/images/druid.jpg",
      'Fighter' => "/images/fighter.jpg",
      'Monk' => "/images/Monk.jpg",
      'Paladin' => "/images/Paladin.jpg",
      'Ranger' => "/images/Ranger.jpg",
      'Rogue' => "/images/Rogue.jpg",
      'Sorcerer' => "/images/sorcerer.jpg",
      'Warlock' => "/images/warlock.jpg",
      'Wizard' => "/images/Wizard.jpg"
    }

    @class_img = class_img_hash[char_class]

  erb :'/characters/show'
end

get '/users/:user_id/characters/:id/edit' do
  erb :'charactes/edit'
end

put '/users/:user_id/characters/:id/upvote' do
  @user = User.find(params[:user_id])
  @character = Character.find(params[:id])
  @new_val = (@character.read_attribute params[:attribute]) + 1
  @character.update(params[:attribute] => @new_val)

  if request.xhr?
    @new_val.to_s
  else
    redirect "/users/#{@user.id}/characters/#{@character.id}"
  end
end

put '/users/:user_id/characters/:id/downvote' do
  @user = User.find(params[:user_id])
  @character = Character.find(params[:id])
  @new_val = (@character.read_attribute params[:attribute]) - 1
  @character.update(params[:attribute] => @new_val)

  if request.xhr?
    @new_val.to_s
  else
    redirect "/users/#{@user.id}/characters/#{@character.id}"
  end
end

delete '/users/:user_id/characters/:id' do
  @user = User.find(params[:user_id])
  @character = Character.find(params[:id])
  @character.destroy
  if request.xhr?
    @user.id.to_s
  else
    redirect "/users/#{@user.id}"
  end
end

