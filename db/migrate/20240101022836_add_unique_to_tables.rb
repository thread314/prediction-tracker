class AddUniqueToTables < ActiveRecord::Migration[7.1]
  def change
    add_index :predictors, :wikiurl, unique: true
  end
end
