class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :description, :category, :user, :price
  has_many_attached :images
end
