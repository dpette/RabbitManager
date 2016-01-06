class CreateCages < ActiveRecord::Migration
  def change
    create_table :cages do |t|
      t.string :name
      t.string :code
      t.integer :farm_id

      t.timestamps null: false
    end
  end
end
