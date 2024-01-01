class AddDefaultToTables < ActiveRecord::Migration[7.1]
  def change
    change_column_default :reports, :status, 0
  end
end
