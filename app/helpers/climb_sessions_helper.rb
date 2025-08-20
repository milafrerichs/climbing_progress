module ClimbSessionsHelper
  def session_duration(climb_session)
    distance_of_time_in_words(climb_session.start, Time.current)
  end
  def format_duration_in_hours_minutes(seconds_diff)
    return "0m" if seconds_diff.nil? || seconds_diff < 0

    hours = seconds_diff / 3600
    minutes = (seconds_diff % 3600) / 60
    # seconds = seconds_diff % 60 # Not needed for H:M output, but useful for JS logic

    parts = []
    parts << "#{hours}h" if hours > 0
    parts << "#{minutes}m" if minutes > 0 || hours == 0 # Always show minutes if no hours

    parts.join(" ")
  end

  # Calculates the difference from start_time to now in seconds
  def duration_seconds_since_start(start_time)
    return nil unless start_time.present?
    (Time.current - start_time).to_i
  end
end
