import consumer from "channels/consumer"

// Cache elements to avoid repeated DOM lookups
const durationElements = {};

// Iterate over all elements that need live duration updates
document.querySelectorAll('[data-climb-session-id]').forEach(element => {
	const sessionId = element.dataset.climbSessionId;
	if (!sessionId) return; // Skip if no session ID

	// Store the element reference
	durationElements[sessionId] = element;

	// Subscribe to the channel for this specific session ID
	consumer.subscriptions.create(
		{ channel: "ClimbSessionDurationChannel", climb_session_id: sessionId },
		{
			connected() {
				// Called when the subscription is ready for use on the server.
				console.log(`ActionCable Connected to ClimbSessionDurationChannel for session ID: ${sessionId}`);
			},

			disconnected() {
				// Called when the subscription has been terminated by the server.
				console.log(`ActionCable Disconnected from ClimbSessionDurationChannel for session ID: ${sessionId}`);
			},

			received(data) {
				// Called when data is received from the channel.
				// data will contain { id: session.id, duration: formatted_duration }
				console.log(`Received update for session ID ${data.id}: ${data.duration}`);
				if (durationElements[data.id]) {
					durationElements[data.id].textContent = data.duration;
				}
			}
		}
	);
});
