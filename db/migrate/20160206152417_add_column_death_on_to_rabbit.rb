class AddColumnDeathOnToRabbit < ActiveRecord::Migration
  def change
    add_column :rabbits, :death_on, :date
  end
end
