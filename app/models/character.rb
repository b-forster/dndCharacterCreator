class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :name, :character_class, :race, :level, :strength, :dexterity, :intelligence,
      :wisdom, :charisma, :user_id, { presence: true }
end