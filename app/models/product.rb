class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items, dependent: :destroy
  
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :active, -> { where("stock > 0") }
end
