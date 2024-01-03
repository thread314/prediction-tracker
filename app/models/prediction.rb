class Prediction < ApplicationRecord
  belongs_to :predictor
  has_many :reports, as: :reportable, dependent: :delete_all
  has_many :comments, as: :commentable, dependent: :delete_all
  has_many :outcomes, dependent: :delete_all 
  validates :title, :body, :duedate, presence: true
  acts_as_votable
end
