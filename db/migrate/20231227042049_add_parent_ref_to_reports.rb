class AddParentRefToReports < ActiveRecord::Migration[7.1]
  def change
    add_reference :reports, :reportable, polymorphic: true, null: false
  end
end
