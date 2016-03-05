class RemoveColumnsConceptionFromRabbit < ActiveRecord::Migration
  def change
    remove_column :rabbits, :conceptioned_on, :date
    remove_column :rabbits, :conceptioner_id, :id
  end
end
