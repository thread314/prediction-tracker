class AddUserAsForeignKey < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :predictors, :users
    add_foreign_key :predictions, :users
    add_foreign_key :outcomes, :users
    add_foreign_key :reports, :users
    add_foreign_key :comments, :users
  end
end
