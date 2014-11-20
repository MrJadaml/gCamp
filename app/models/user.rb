class User < ActiveRecord::Base
  has_many :memberships
  has_many :projects, through: :memberships
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  has_secure_password

  def full_name
    [first_name, last_name].join(' ')
  end

end
