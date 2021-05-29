class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  
  validates :name, presence: true
  validates_uniqueness_of :name

  has_one_attached :photo
end
