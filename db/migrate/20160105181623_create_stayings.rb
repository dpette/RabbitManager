class CreateStayings < ActiveRecord::Migration
  def change
    create_table :stayings do |t|
      t.integer :rabbit_id
      t.integer :compartment_id
      t.datetime :starting_at
      t.datetime :ending_at

      t.timestamps null: false
    end
  end
end
