class Prediction < ApplicationRecord
  belongs_to :predictor
  has_many :reports, as: :reportable
end
