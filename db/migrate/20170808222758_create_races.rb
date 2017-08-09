class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name, { null:false }
      t.integer :strength_bonus, { default: 0 }
      t.integer :dexterity_bonus, { default: 0 }
      t.integer :constitution_bonus, { default: 0 }
      t.integer :intelligence_bonus, { default: 0 }
      t.integer :wisdom_bonus, { default: 0 }
      t.integer :charisma_bonus, { default: 0 }

      t.timestamps(null:false)
    end
  end
end
