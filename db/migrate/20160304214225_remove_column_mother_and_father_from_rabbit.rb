class RemoveColumnMotherAndFatherFromRabbit < ActiveRecord::Migration
  def change
    remove_column :rabbits, :mother_id, :integer
    remove_column :rabbits, :father_id, :integer
  end
end
