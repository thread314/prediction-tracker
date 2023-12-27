class AddParentRefToReports < ActiveRecord::Migration[7.1]
  def change
    add_reference :reportable, polymorphic: true
  end
end
