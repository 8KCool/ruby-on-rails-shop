class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :product, presence: true
  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
