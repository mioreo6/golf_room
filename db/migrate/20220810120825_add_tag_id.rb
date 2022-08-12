class AddTagId < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_tags, :tag, foreign_key: true
  end
end
