class AddColumnsConceptionToRabbit < ActiveRecord::Migration
  def change
    add_column :rabbits, :conceptioned_on, :date
    add_column :rabbits, :conceptioner_id, :integer

    add_index :rabbits, :conceptioner_id

  end
end
