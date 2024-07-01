class RecalculateAvgGasBurntWorker
  include Sidekiq::Worker

  def perform(blockchain_id)
    blockchain = Blockchain.find(blockchain_id)
    avg_gas_burnt = blockchain.block_transactions.average(:gas_burnt)
    blockchain.update(avg_gas_burnt: avg_gas_burnt)
  end
end
