class Order < ActiveRecord::Base
  validates :products, presence: true
  validates :count, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
