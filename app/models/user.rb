class User < ActiveRecord::Base
  has_many :events
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, :presence => true
  validates :email, :presence => true, :format => { with: EMAIL_REGEX }, :uniqueness => { case_sensitive: false }
  validates :state, :presence => true, :length => { maximum: 2 }
  before_save :downcase_email

  private
    def downcase_email
      self.email.downcase!
    end
end
