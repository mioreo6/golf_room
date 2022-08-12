class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :favorites, dependent: :destroy
end
