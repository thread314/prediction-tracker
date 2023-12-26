class CreatePredictions < ActiveRecord::Migration[7.1]
  def change
    create_table :predictions do |t|
      t.string :title
      t.text :body
      t.date :duedate

      t.timestamps
    end
  end
end
