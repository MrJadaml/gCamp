class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :projects, through: :memberships


  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  has_secure_password

  def full_name
    [first_name.capitalize, last_name.capitalize].join(' ')
  end

end
