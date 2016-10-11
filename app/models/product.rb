class Product < ActiveRecord::Base
  mount_uploader :image, ProductsImageUploader
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :prior, numericality: { only_integer: true }

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc) }
end
