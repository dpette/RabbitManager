class AddColumnPregnancyIdToRabbit < ActiveRecord::Migration
  def change
    add_column :rabbits, :pregnancy_id, :integer

    add_index :rabbits, :pregnancy_id
  end
end
