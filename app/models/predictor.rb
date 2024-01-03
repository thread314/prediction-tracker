class Predictor < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search,
                  against: :title,
                  using: {tsearch: { prefix: true }}
  has_many :predictions, dependent: :delete_all
  belongs_to :user

end
