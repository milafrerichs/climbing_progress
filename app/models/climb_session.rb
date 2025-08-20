class ClimbSession < ApplicationRecord
  belongs_to :location
  belongs_to :user
  has_many :climb_logs

  def duration
    (self.end - self.start).to_i
  end

  def date_str
    if self.start.year == DateTime.now.year
      self.start.strftime("%d.%m")
    else
      self.start.strftime("%d.%m.%Y")
    end
  end
end
