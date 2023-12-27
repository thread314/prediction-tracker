class CreateOutcomes < ActiveRecord::Migration[7.1]
  def change
    create_table :outcomes do |t|
      t.integer :result
      t.text :body
      t.belongs_to :prediction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
