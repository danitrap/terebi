class Episode < ActiveRecord::Base
  belongs_to :series

  validates :name, presence: true
  validates :path, presence: true, uniqueness: true
end
