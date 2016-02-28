class AddColumnNotesToRabbit < ActiveRecord::Migration
  def change
    add_column :rabbits, :notes, :text
  end
end
