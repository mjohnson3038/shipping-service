class Package < ActiveRecord::Base
  validates :state, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :weight, presence: true

end
