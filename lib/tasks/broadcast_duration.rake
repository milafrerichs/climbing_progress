namespace :duration do
  desc "Broadcasts current duration for active climb sessions via ActionCable"
  task broadcast_active_sessions: :environment do
    Rails.logger.level = :debug # <--- Add this for debugging
    Rails.logger.info "Starting duration broadcast for active climb sessions..."

    # Find active sessions (e.g., those that have started but not ended)
    active_sessions = ClimbSession.where.not(start: nil).where(end: nil)

    active_sessions.each do |session|
      # Calculate duration on the server
      seconds_diff = (Time.current - session.start).to_i

      hours = seconds_diff / 3600
      minutes = (seconds_diff % 3600) / 60

      parts = []
      parts << "#{hours}h" if hours > 0
      parts << "#{minutes}m" if minutes > 0 || hours == 0 # Always show minutes if no hours

      formatted_duration = parts.join(" ")

      Rails.logger.info "Attempting to broadcast for session ID #{session.id} with data: #{ { id: session.id, duration: formatted_duration, started_at: session.start.iso8601(3) }.inspect }"
      # Broadcast the updated duration to the specific session's stream
      ClimbSessionDurationChannel.broadcast_to(
        session, # The object to stream for (maps to stream_for session in channel)
        {
          id: session.id,
          duration: formatted_duration,
          started_at: session.start.iso8601(3) # Can also send start_time for client-side fallback/debug
        }
      )
      Rails.logger.debug "Broadcasted duration for ClimbSession ID #{session.id}: #{formatted_duration}"
    end

    Rails.logger.info "Finished duration broadcast."
  end
end
