class Order < ActiveRecord::Base
  has_many :order_items # dependent: destroy
  accepts_nested_attributes_for :order_items,
                                allow_destroy: true,
                                reject_if: :all_blank
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
