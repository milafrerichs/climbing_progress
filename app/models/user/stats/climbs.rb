class User::Stats::Climbs
  def initialize(user)
    @climb_logs = user.climb_logs.last_30_days.order(:date)
    @past_30_to_90_day_logs = user.climb_logs.from_90_to_30_days_ago
  end

  def last_30d_count
    @climb_logs.count
  end

  def increase?
    increased_by > 0
  end

  def increased_by
    @climb_logs.count - @past_30_to_90_day_logs.count
  end

  def average_grade
    @climb_logs.average(:grade)
  end

  def average_per_day
    average(@climb_logs)
  end

  def average_per_day_increase_by
    average_per_day - average(@past_30_to_90_day_logs)
  end

  def average_per_day_increase?
    average_per_day_increase_by > 0
  end

  private
  def average(climb_logs)
    days = climb_logs.select(:date).distinct.count
    days > 0 ? climb_logs.count.to_f / days : 0.0
  end
end
