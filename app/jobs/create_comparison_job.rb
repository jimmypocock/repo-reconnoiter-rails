# CreateComparisonJob - Background job for asynchronous comparison creation
#
# Handles comparison creation in the background with real-time progress updates
# via ActionCable. Orchestrates ComparisonCreator with progress broadcasting.
#
# Usage:
#   CreateComparisonJob.perform_later(user.id, "Rails background jobs", session_id)
class CreateComparisonJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: :polynomially_longer, attempts: 2 do |job, error|
    job.broadcast_retry_exhausted(error)
  end

  #--------------------------------------
  # PUBLIC INSTANCE METHODS
  #--------------------------------------

  def broadcast_retry_exhausted(error)
    user_id, query, session_id = arguments
    broadcaster = ComparisonProgressBroadcaster.new(session_id)
    status_record = ComparisonStatus.find_by(session_id: session_id)

    # DEBUG: Log the actual error
    Rails.logger.error "=" * 80
    Rails.logger.error "[CreateComparisonJob] RETRY EXHAUSTED"
    Rails.logger.error "Error class: #{error.class}"
    Rails.logger.error "Error message: #{error.message}"
    Rails.logger.error "Backtrace:"
    Rails.logger.error error.backtrace.first(15).join("\n")
    Rails.logger.error "Session ID: #{session_id}"
    Rails.logger.error "Comparison exists: #{Comparison.exists?(status_record&.comparison_id)}" if status_record&.comparison_id
    Rails.logger.error "=" * 80

    Sentry.capture_exception(error, extra: {
      job: "CreateComparisonJob",
      user_id:,
      query:,
      session_id:,
      executions:
    })

    error_msg = error_message_for(error)
    status_record&.fail!(error_msg)
    broadcaster.broadcast_error(error_msg)
  end

  def perform(user_id, query, session_id)
    Rails.logger.info "[CreateComparisonJob] Starting - Session: #{session_id}, Query: #{query}"

    user = User.find(user_id)
    broadcaster = ComparisonProgressBroadcaster.new(session_id)
    status_record = ComparisonStatus.find_by(session_id: session_id)

    Rails.logger.info "[CreateComparisonJob] Creating comparison..."
    result = ComparisonCreator.new(
      query: query,
      user: user,
      session_id: session_id
    ).call
    Rails.logger.info "[CreateComparisonJob] Comparison created! ID: #{result.record.id}"

    # Update status to completed
    Rails.logger.info "[CreateComparisonJob] Updating status to completed..."
    status_record&.complete!(result.record)
    Rails.logger.info "[CreateComparisonJob] Status updated successfully"

    # Broadcast completion
    Rails.logger.info "[CreateComparisonJob] Broadcasting completion..."
    broadcaster.broadcast_complete(result.record.id)
    Rails.logger.info "[CreateComparisonJob] Broadcast successful - Job complete!"

  rescue ComparisonCreator::InvalidQueryError => e
    Rails.logger.error "[CreateComparisonJob] Invalid query error: #{e.message}"
    error_msg = "Invalid query: #{e.message}"
    status_record&.fail!(error_msg)
    broadcaster.broadcast_error(error_msg)
  rescue ComparisonCreator::NoRepositoriesFoundError => e
    Rails.logger.error "[CreateComparisonJob] No repositories found: #{e.message}"
    error_msg = "No repositories found. Try a different query."
    status_record&.fail!(error_msg)
    broadcaster.broadcast_error(error_msg)
  rescue => e
    # DEBUG: Catch any unexpected errors
    Rails.logger.error "=" * 80
    Rails.logger.error "[CreateComparisonJob] UNEXPECTED ERROR in perform"
    Rails.logger.error "Error class: #{e.class}"
    Rails.logger.error "Error message: #{e.message}"
    Rails.logger.error "Backtrace:"
    Rails.logger.error e.backtrace.first(15).join("\n")
    Rails.logger.error "=" * 80
    raise # Re-raise to trigger retry mechanism
  end

  private

  #--------------------------------------
  # PRIVATE METHODS
  #--------------------------------------

  def error_message_for(error)
    case error
    when Octokit::TooManyRequests
      "GitHub rate limit reached. Please try again in a few minutes."
    when Faraday::TimeoutError
      "Request timed out. Please try again."
    else
      "Something went wrong. Please try again."
    end
  end
end
