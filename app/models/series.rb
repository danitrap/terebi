class Series < ActiveRecord::Base
  has_many :episodes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
