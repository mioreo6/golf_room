class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, null: false
      t.integer :tag_id, null: false
      
      t.timestamps
    end
    add_foreign_key :post_tags, :posts
    add_foreign_key :post_tags, :tags
   
  end
end
