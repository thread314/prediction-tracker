class Report < ApplicationRecord

  enum reason: {"Misleading/inaccurate" => 0,
                "Replacement link" => 1,
                "Offensive content" => 2,
                "Other" => 3,
                "Not directly quoted" => 4,
                "Not objectively measurable" => 5,
                "No objective time frame" => 6,
                "No original source/citation" => 7,
                "Wrong predictor" => 8,
                "Duplicate" => 9}

  enum status: {"Pending" => 0,
                "Upheld" => 1,
                "Dismissed" => 2}
  belongs_to :reportable, polymorphic: true

end
