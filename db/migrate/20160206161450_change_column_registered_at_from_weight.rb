class ChangeColumnRegisteredAtFromWeight < ActiveRecord::Migration
  def up
    change_column :weights, :registered_at, :date
    rename_column :weights, :registered_at, :registered_on
  end

  def down
    change_column :weights, :registered_on, :datetime
    rename_column :weights, :registered_on, :registered_at
  end
end
