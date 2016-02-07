class AddSomeIndexes < ActiveRecord::Migration
  def change
    add_index :cages, :farm_id

    add_index :compartments, :cage_id

    add_index :farms, :user_id

    add_index :rabbits, :father_id
    add_index :rabbits, :mother_id

  end
end
