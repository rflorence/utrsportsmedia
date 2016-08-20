class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  class NotAuthorized < StandardError
  end

  def is_admin?
    role == "admin"
  end

  def is_paid?
    role == "paid" || is_admin?
  end
end
