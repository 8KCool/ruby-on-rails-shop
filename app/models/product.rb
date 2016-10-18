class Product < ActiveRecord::Base
  mount_uploader :image, ProductsImageUploader
  paginates_per 8
  belongs_to :category

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :price, format: { with: /\A[0-9]+(\.[0-9]{1,2})?\z/ }, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :saleprice, format: { with: /\A[0-9]+(\.[0-9]{1,2})?\z/ }, numericality: { greater_than_or_equal_to: 0 }
  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :prior, numericality: { only_integer: true }

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc) }
end
