module NEAR
  class SyncBlockWorker
    include Sidekiq::Worker

    # Prevent retries to avoid triggering overlapping syncs
    sidekiq_options retry: 0

    def perform(block_data)
      return if Block.find_by(hash: block_data["block_hash"])

      # validate block_data depending on how immutable block data is
      # -- let's assume that it is immutable since it's on the chain

      block = Block.create!(
        block_id: block_data["block_id"],
        hash: block_data["block_hash"],
        height: block_data["height"],
        time: block_data["time"],
        created_at: block_data["created_at"],
        updated_at: block_data["updated_at"],
        blockchain_id: Blockchain.find_by(name: Blockchain::NEAR_BLOCKCHAIN_NAME).id
      )

      transaction = BlockTransaction.create!(
        block: block,
        hash: block_data["hash"],
        sender: block_data["sender"],
        receiver: block_data["receiver"],
        gas_burnt: block_data["gas_burnt"].to_i,
        success: block_data["success"],
        actions_count: block_data["actions_count"]
      )

      block_data["actions"].each do |action|
        Action.create!(
          block_transaction: transaction,
          action_type: action["type"],
          data: action["data"].to_json
        )
      end
    rescue StandardError => e
      Rails.logger.error "Error syncing block data: #{block_data["block_hash"]} - #{e.message}"
      raise # Propagates the error to APM services for potential alerting
            # despite us not retrying the job
    end
  end
end
