class Api::V1::BlockchainsController < ApplicationController
  def show_near_avg_gas_burnt
    blockchain = Blockchain.find_by(name: Blockchain::NEAR_BLOCKCHAIN_NAME)
    render json: { blockchain_id: blockchain.id, avg_gas_burnt: blockchain.avg_gas_burnt }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Blockchain not found' }, status: :not_found
  end
end
