class Product < ApplicationRecord
  has_one_attached :product_image
  has_rich_text :description
  validates :name, presence: true
end
