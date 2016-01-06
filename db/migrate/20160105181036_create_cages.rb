class CreateCages < ActiveRecord::Migration
  def change
    create_table :cages do |t|
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
