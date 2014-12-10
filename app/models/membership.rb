class Membership<ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, uniqueness: {scope: :project_id}
  validates :user, presence: :true

  before_destroy :confirm_owner_count

  def confirm_owner_count
    owners = project.memberships.where('role = ?', 'Owner')
    if owners.count == 1 && role == 'Owner'
      return false
    end
  end
end
