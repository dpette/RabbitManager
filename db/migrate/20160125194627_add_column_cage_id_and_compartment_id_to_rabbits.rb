class AddColumnCageIdAndCompartmentIdToRabbits < ActiveRecord::Migration
  def change
    add_column :rabbits, :container_id, :integer
    add_column :rabbits, :container_type, :string
    add_index :rabbits, :container_id
  end
end
