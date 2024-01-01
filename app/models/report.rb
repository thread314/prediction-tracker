class Report < ApplicationRecord

  enum reason: {"Not directly quoted" => 0,
                "Not objectively measurable" => 1,
                "No objective time frame" => 2,
                "No original source/citation" => 3,
                "Duplicate" => 4,
                "Misleading/inaccurate" => 5,
                "Replacement link" => 6,
                "Offensive content" => 7,
                "Other" => 8}

  enum status: {"Pending" => 0,
                "Upheld" => 1,
                "Dismissed" => 2}
  
  belongs_to :reportable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :delete_all
  validates :body, :reason, presence: true

end
