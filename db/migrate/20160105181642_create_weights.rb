class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.float :value
      t.datetime :registered_at

      t.timestamps null: false
    end
  end
end
