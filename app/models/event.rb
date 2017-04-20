class Event < ActiveRecord::Base
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users, through: :joins
  validates :name, :city, :user, :presence => true
  validates :state, :presence => true, :length => { maximum: 2 }
  validates :date, :presence => true, on: :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    if self.date.present? && self.date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
