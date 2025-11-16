class SyncTrendingRepositoriesJob < ApplicationJob
  queue_as :default

  def perform
    result = RepositorySyncer.sync_trending(days_ago: 7, min_stars: 50, per_page: 10)

    result[:repositories].each do |repo|
      # Skip if already in queue or already analyzed
      next if QueuedAnalysis.exists?(repository_id: repo.id, status: [ "pending", "processing" ])

      # Calculate priority based on stars (more stars = higher priority)
      priority = calculate_priority(repo)

      QueuedAnalysis.enqueue_for_repository(
        repo,
        analysis_type: "Analysis",
        priority: priority
      )
    end
  end

  private

  #--------------------------------------
  # PRIVATE METHODS
  #--------------------------------------

  def calculate_priority(repo)
    # Higher stars = higher priority (0-10 scale)
    case repo.stargazers_count
    when 0..100 then 0
    when 101..500 then 2
    when 501..1000 then 4
    when 1001..5000 then 6
    when 5001..10000 then 8
    else 10
    end
  end
end
