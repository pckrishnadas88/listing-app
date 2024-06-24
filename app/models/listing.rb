class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :description, :category, :user
  has_many_attached :images
end
