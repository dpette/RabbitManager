class RemoveColumDeathOnToRabbit < ActiveRecord::Migration
  def change
    remove_column :rabbits, :death_on, :date
    # remove_column :rabbits, :cage_id, :integer
  end
end
