class SetUserToNonNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :predictors, :user_id, false
    change_column_null :predictions, :user_id, false
    change_column_null :outcomes, :user_id, false
    change_column_null :reports, :user_id, false
    change_column_null :comments, :user_id, false
  end
end
