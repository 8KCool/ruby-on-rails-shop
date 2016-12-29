class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
