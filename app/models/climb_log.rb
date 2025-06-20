class ClimbLog < ApplicationRecord
  enum :climb_type, %i[Unspecific Slab Overhang Dynamic]
  belongs_to :user
  belongs_to :location

  validates :status, inclusion: { in: %w[Flash Top Project] }
  validates :tries, numericality: { greater_than_or_equal_to: 1 }
  validate :status_consistent_with_tries

  scope :last_30_days, -> { where(date: 30.days.ago...) }
  scope :from_90_to_30_days_ago, -> { where(date: 90.days.ago...30.days.ago) }

  def status_consistent_with_tries
    if status
      if tries == 1 && status != "Flash"
        errors.add(:status, "must be Flash if tries is 1")
      elsif tries > 1 && tries <= 5 && status != "Top"
        errors.add(:status, "must be Top if tries is between 1 and 5")
      elsif tries > 5 && status != "Project"
        errors.add(:status, "must be Project if tries is > 5")
      end
    end
  end
end
