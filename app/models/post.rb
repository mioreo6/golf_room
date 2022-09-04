class Post < ApplicationRecord
  has_one_attached  :image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def self.search(search)
    if search
       where(['body LIKE ?', "%#{search}%"])
    else
       all #全て表示させる
    end
  end
end
