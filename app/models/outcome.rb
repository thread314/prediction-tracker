class Outcome < ApplicationRecord
  belongs_to :prediction
  enum result: { confirmed: 0, disconfirmed: 1, inconclusive: 2 }
end
