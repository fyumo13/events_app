class Event < ActiveRecord::Base
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users, through: :joins
  validates :name, :city, :date, :user, :presence => true
  validates :state, :presence => true, :length => { maximum: 2 }
end
