class CreateRabbits < ActiveRecord::Migration
  def change
    create_table :rabbits do |t|
      t.string :name
      t.string :gender
      t.integer :father_id
      t.integer :mother_id
      # t.boolean :race
      t.date :birth_date
      t.date :death_date
      t.string :type

      t.timestamps null: false
    end
  end
end
