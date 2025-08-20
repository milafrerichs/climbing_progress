class ClimbSessionDurationChannel < ApplicationCable::Channel
  def subscribed
    # Find the climb session based on the ID passed from the client
    climb_session = ClimbSession.find_by(id: params[:climb_session_id])

    if climb_session
      # Stream to a unique stream for this specific climb session
      # This allows broadcasting updates to all clients subscribed to this session.
      stream_for climb_session
      Rails.logger.info "Subscribed to ClimbSessionDurationChannel for ClimbSession ID: #{climb_session.id}"
    else
      reject # Reject the subscription if the session doesn't exist
      Rails.logger.warn "Rejected subscription to ClimbSessionDurationChannel: ClimbSession ID #{params[:climb_session_id]} not found."
    end
  end

  def unsubscribed
    # Any cleanup needed when a client disconnects.
    Rails.logger.info "Unsubscribed from ClimbSessionDurationChannel for ClimbSession ID: #{params[:climb_session_id]}"
  end
end
