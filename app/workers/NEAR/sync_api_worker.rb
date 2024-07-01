module NEAR
    class SyncApiWorker
    include Sidekiq::Worker

    # Prevent retries to avoid triggering overlapping syncs
    sidekiq_options retry: 0

    def perform
      near_api_service = ::NEAR::ApiService.new
      blocks = near_api_service.fetch_blocks_with_transactions

      blocks.each do |block_data|
        ::NEAR::SyncBlockWorker.perform_async(block_data)
      end
    rescue StandardError => e
      Rails.logger.error "Error syncing data from NEAR API: #{e.class} - #{e.message}"
      raise # Propagates the error to APM services for potential alerting
            # despite us not retrying the job
    end
  end
end
