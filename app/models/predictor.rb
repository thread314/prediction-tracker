class Predictor < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search,
                  against: :title,
                  using: {tsearch: { prefix: true }}

end
