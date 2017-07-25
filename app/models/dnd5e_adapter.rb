module Dnd5eAdapter

  def self.generate_race_num_hash
    race_obj ||= HTTParty.get("http://5e-api.com/v1/race/")
    $race_num_hash = {}

    race_obj.each do |race|
      if race["subrace"] == nil
        $race_num_hash[race["name"]] = race["id"]
      else
        $race_num_hash[race["subrace"]] = race["id"]
      end
    end

    p $race_num_hash
  end

  def self.get_race_num(race)
    Dnd5eAdapter.generate_race_num_hash if !$race_num_hash
    $race_num_hash[race].to_s
  end

  def self.racial_bonus(race)
    race_num = Dnd5eAdapter.get_race_num(race)
    racial_bonus_obj = HTTParty.get("http://5e-api.com/v1/race/#{race_num}")
    p racial_bonuses_array = racial_bonus_obj["ability_bonuses"]
  end
end