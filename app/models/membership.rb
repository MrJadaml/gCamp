class Membership<ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, uniqueness: :true
  validates :user, presence: :true

end
