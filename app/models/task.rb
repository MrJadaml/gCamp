class Task < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :description, presence: true
  validate :date_cant_be_in_past, on: :create

  belongs_to :project

  def date_cant_be_in_past
    if self.due_date.present? && self.due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

end
