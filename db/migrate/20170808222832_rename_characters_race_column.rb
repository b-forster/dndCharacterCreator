class RenameCharactersRaceColumn < ActiveRecord::Migration
  def change
    remove_column :characters, :race
    add_reference :characters, :race, foreign_key: true
  end
end
