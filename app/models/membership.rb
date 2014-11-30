class Membership<ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, uniqueness: {scope: :project_id}
  validates :user, presence: :true

end
