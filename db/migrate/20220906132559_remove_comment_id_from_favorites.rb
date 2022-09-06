class RemoveCommentIdFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :comment_id, :integer
  end
end
