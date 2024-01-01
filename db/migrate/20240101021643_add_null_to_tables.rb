class AddNullToTables < ActiveRecord::Migration[7.1]
  def change
    change_column_null :predictors, :wikiurl, false
    change_column_null :predictors, :title, false
    change_column_null :predictions, :title, false
    change_column_null :predictions, :body, false
    change_column_null :predictions, :duedate, false
    change_column_null :outcomes, :result, false
    change_column_null :outcomes, :body, false
    change_column_null :reports, :reason, false
    change_column_null :reports, :body, false
    change_column_null :reports, :status, false
    change_column_null :comments, :body, false
  end
end
