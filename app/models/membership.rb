class Membership<ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, :role, presence: :true, uniqueness: :true
end
