class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.float :value
      t.datetime :registered_at
      t.integer :rabbit_id

      t.timestamps null: false
    end

    add_index :weights, :rabbit_id
  end
end
