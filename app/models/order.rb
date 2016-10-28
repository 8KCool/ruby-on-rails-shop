class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  accepts_nested_attributes_for :order_items,
                                allow_destroy: true,
                                reject_if: :all_blank
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, numericality: { greater_than_or_equal_to: 0 }
  scope :waiting, -> { where(status: 0) }
  scope :confirmed, -> { where(status: 1) }
  scope :rejected, -> { where(status: 2) }
  scope :shipped, -> { where(status: 3) }

  after_create :send_email

  def send_email
    OrderMailer.order_message(self).deliver_now
  end
end
