class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :favorites, :post_id, true
    change_column_null :favorites, :comment_id, true
  end
  
  def down
    change_column_null :favorites, :post_id, false
    change_column_null :favorites, :comment_id, false
  end
end
