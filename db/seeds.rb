p races_array = Dnd5eAdapter.generate_races_array
races_array.each do |race|
  p new_race = Race.create_with(Dnd5eAdapter.generate_racial_bonus_hash(race)).find_or_create_by(name: race)
end