class Episode < ActiveRecord::Base
  belongs_to :series, touch: true

  validates :name, presence: true
  validates :path, presence: true, uniqueness: true
end
