class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
