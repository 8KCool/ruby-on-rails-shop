class Category < ActiveRecord::Base
  validates :name, presence: true #TODO: add uniqueness check
end
