class Task < ActiveRecord::Base
  validates :description, :due_date, presence: true
  validate :date_cant_be_in_past

  def date_cant_be_in_past
    if self.due_date.present? && self.due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

end
