class AddColumTypeToCage < ActiveRecord::Migration
  def change
    add_column :cages, :type, :string
  end
end
