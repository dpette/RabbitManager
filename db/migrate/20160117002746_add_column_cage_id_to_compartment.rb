class AddColumnCageIdToCompartment < ActiveRecord::Migration
  def change
    add_column :compartments, :cage_id, :integer
  end
end
