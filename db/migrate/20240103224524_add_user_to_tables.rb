class AddUserToTables < ActiveRecord::Migration[7.1]
  def change
    add_column :predictors, :user_id, :integer
    add_column :predictions, :user_id, :integer
    add_column :outcomes, :user_id, :integer
    add_column :reports, :user_id, :integer
    add_column :comments, :user_id, :integer
  end
end
