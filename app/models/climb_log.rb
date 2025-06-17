class ClimbLog < ApplicationRecord
  enum :climb_type, %i[Unspecific Slab Overhang Dynamic]
  belongs_to :user

  validates :status, inclusion: { in: %w[Flash Top Project] }
  validates :tries, numericality: { greater_than_or_equal_to: 1 }
  validate :status_consistent_with_tries

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
