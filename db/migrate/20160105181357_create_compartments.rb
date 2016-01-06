class CreateCompartments < ActiveRecord::Migration
  def change
    create_table :compartments do |t|
      t.integer :code
      t.integer :name

      t.timestamps null: false
    end
  end
end
