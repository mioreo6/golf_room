class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
       t.integer :customer_id, null: false
       t.integer :post_id, null: false
       t.integer :comment_id, null: false

      t.timestamps
    end
     add_foreign_key :favorites, :customers
     add_foreign_key :favorites, :posts
     add_foreign_key :favorites, :comments

  end
end
