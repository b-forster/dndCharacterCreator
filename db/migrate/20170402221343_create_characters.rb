class CreateCharacters < ActiveRecord::Migration
  def change
  	create_table :characters do |t|
  		t.string :name, { null:false }
  		t.string :character_class, { null:false }
  		t.string :race, { null:false }
  		t.string :alignment
  		t.text :background

      t.integer :level, { null:false }
      
  		t.integer :strength, { null:false }
  		t.integer :dexterity, { null:false }
  		t.integer :constitution, { null:false }
  		t.integer :intelligence, { null:false }
  		t.integer :wisdom, { null:false }
  		t.integer :charisma, { null:false }

  		t.references :user, { null:false }
      t.timestamps(null:false)
    end
  end
end
