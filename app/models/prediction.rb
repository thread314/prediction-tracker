class Prediction < ApplicationRecord
  belongs_to :predictor
  has_many :reports, as: :reportable
  has_many :comments, as: :commentable
  has_many :outcomes
end
