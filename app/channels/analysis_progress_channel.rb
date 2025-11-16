# AnalysisProgressChannel - Real-time progress updates for deep analysis
#
# Streams progress events from CreateDeepAnalysisJob to the client browser.
# Uses session_id for stream isolation (multiple concurrent analyses).
#
# Client subscription example (Stimulus):
#   consumer.subscriptions.create(
#     { channel: "AnalysisProgressChannel", session_id: "abc-123" },
#     { received: (data) => this.updateProgress(data) }
#   )
class AnalysisProgressChannel < ApplicationCable::Channel
  def subscribed
    # Ensure session_id parameter is provided
    session_id = params[:session_id]

    if session_id.blank?
      reject
      return
    end

    # Stream from the analysis progress channel
    # This receives broadcasts from AnalysisProgressBroadcaster
    stream_from "analysis_progress_#{session_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
