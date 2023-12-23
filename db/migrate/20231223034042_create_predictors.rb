class CreatePredictors < ActiveRecord::Migration[7.1]
  def change
    create_table :predictors do |t|
      t.string :wikiurl
      t.string :title
      t.string :image
      t.text :summary

      t.timestamps
    end
  end
end
