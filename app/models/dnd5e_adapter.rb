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

    $race_num_hash  # return array of hashes, pass to create method in seed file
  end

  def self.generate_races_array
    Dnd5eAdapter.generate_race_num_hash if !$race_num_hash
    $races_array = $race_num_hash.keys
  end

  def self.get_race_num(race)
    Dnd5eAdapter.generate_race_num_hash if !$race_num_hash
    $race_num_hash[race].to_s
  end

  def self.get_racial_bonuses_array(race)
    race_num = Dnd5eAdapter.get_race_num(race)
    racial_bonus_obj = HTTParty.get("ttp://5e-api.com/v1/race/h#{race_num}")
    racial_bonuses_array = racial_bonus_obj["ability_bonuses"]
  end

  def self.generate_racial_bonus_hash(race)
    racial_bonuses_array = Dnd5eAdapter.get_racial_bonuses_array(race)
    racial_bonus_hash = {}

    racial_bonuses_array.each do |bonus|
      racial_bonus_hash[(bonus["ability"]["name"].downcase + "_bonus").to_sym] = bonus["bonus"].to_i
    end

    racial_bonus_hash
  end
end