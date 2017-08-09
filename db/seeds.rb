Character.destroy_all

# char = Character.last

# race = Race.create(
#   {
#     name: "Human",
#     strength_bonus: 1,
#     dexterity_bonus: 2,
#     wisdom_bonus: 3,
#     charisma_bonus: 4
#   }
# )

# char.race = race

# char.save

p races_array = Dnd5eAdapter.generate_races_array
sleep 60
races_array.each do |race|
  # bonus_hash = Dnd5eAdapter.generate_racial_bonus_hash(race)
  new_race = Race.create_with(Dnd5eAdapter.generate_racial_bonus_hash(race)).find_or_create_by(name: race)
  sleep 60 
end