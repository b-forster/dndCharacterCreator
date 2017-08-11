get '/users/:user_id/characters' do
  erb :'characters/index'
end

get '/users/:user_id/characters/new' do
  @races_array = Dnd5eAdapter.generate_races_array
  erb :'/characters/new'
end

post '/users/:user_id/characters' do
  p "*" * 100 

  race_name = params[:character][:race]
  race_object = Race.find_by(name: race_name)
  params[:character]["race"] = race_object
  params[:character]["user_id"] = current_user.id
  p @character = Character.new(params[:character])

  p params

  if @character.valid?

  #   # Add racial bonuses to stats of newly created character

    @character.strength  += race_object.strength_bonus
    @character.dexterity += race_object.dexterity_bonus
    @character.constitution += race_object.constitution_bonus
    @character.intelligence += race_object.intelligence_bonus
    @character.wisdom += race_object.wisdom_bonus
    @character.charisma += race_object.charisma_bonus
    
    if @character.save
      redirect "/users/#{current_user.id}"
    else
      @errors = @character.errors.full_messages
      erb :'characters/new'
    end
  else
    @errors = @character.errors.full_messages
    erb :'characters/new'
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

