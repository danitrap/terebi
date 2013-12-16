class Series < ActiveRecord::Base
  has_many :episodes, dependent: :destroy
end
