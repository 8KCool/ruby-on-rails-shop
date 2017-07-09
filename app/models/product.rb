class Product < ActiveRecord::Base
  mount_uploader :image, ProductsImageUploader
  paginates_per 8
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :price, format: { with: /\A[0-9]+(\.[0-9]{1,2})?\z/ }, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :saleprice, format: { with: /\A[0-9]+(\.[0-9]{1,2})?\z/ }, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :prior, numericality: { only_integer: true }

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc, id: :desc) }

  def curprice
    if self.saletime && self.saleprice
      have_saleprice = self.saleprice > 0 && self.saletime > DateTime.now
    else
      have_saleprice = false
    end

    if have_saleprice
      self.saleprice
    else
      self.price
    end
  end
end
