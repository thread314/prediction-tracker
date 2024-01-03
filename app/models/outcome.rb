class Outcome < ApplicationRecord
  belongs_to :prediction 
  enum result: { confirmed: 0, disconfirmed: 1, inconclusive: 2 }
  has_many :reports, as: :reportable, dependent: :delete_all 
  has_many :comments, as: :commentable, dependent: :delete_all
  validates :body, :result, presence: true
  acts_as_votable
  belongs_to :user
end
