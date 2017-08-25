require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :characters

  validates :email, :username, presence: true, uniqueness: true
  validate :is_valid_password?
  validates_format_of :email, :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @plain_text_password = new_password
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def is_valid_password?
    if @plain_text_password.length == 0
      errors.add(:password, "can't be blank")
    elsif @plain_text_password.length < 6
      errors.add(:password, "must be 6 or more characters")
    end
  end
end
