class DownColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :favorites, :customer_id, true
  end
  
  def down
    change_column_null :favorites, :customer_id, false
  end
end
