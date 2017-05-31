class Character < ActiveRecord::Base
  belongs_to :user

  validates :name, :race, :alignment, :level, :strength, :dexterity, :intelligence,
      :wisdom, :charisma, :user_id, { presence: true }
end