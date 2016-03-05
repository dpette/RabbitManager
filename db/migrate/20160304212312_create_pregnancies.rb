class CreatePregnancies < ActiveRecord::Migration
  def change
    create_table :pregnancies do |t|
      t.date :starting_at
      t.date :ending_at
      t.integer :rabbit_id

      t.timestamps null: false
    end

    add_index :pregnancies, :rabbit_id
  end
end
