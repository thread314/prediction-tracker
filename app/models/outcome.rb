class Outcome < ApplicationRecord
  belongs_to :prediction
  enum result: { confirmed: 0, disconfirmed: 1, inconclusive: 2 }
  has_many :reports, as: :reportable
  has_many :comments, as: :commentable
end
