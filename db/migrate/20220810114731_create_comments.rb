class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :customer_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
    add_foreign_key :comments, :posts
    add_foreign_key :comments, :customers
  end
end
