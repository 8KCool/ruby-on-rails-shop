class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  accepts_nested_attributes_for :order_items,
                                allow_destroy: true,
                                reject_if: :all_blank,
                                allow_destroy: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
