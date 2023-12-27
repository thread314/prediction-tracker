class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.integer :reason
      t.text :body
      t.integer :status

      t.timestamps
    end
  end
end
