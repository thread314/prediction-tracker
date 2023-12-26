class AddPredictorRefToPredictions < ActiveRecord::Migration[7.1]
  def change
    add_reference :predictions, :predictor, null: false, foreign_key: true
  end
end
