class Api::V1::BlockchainsController < ApplicationController
  def show_avg_gas_burnt
    blockchain = Blockchain.find(params[:id])
    render json: { blockchain_id: blockchain.id, avg_gas_burnt: blockchain.avg_gas_burnt }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Blockchain not found' }, status: :not_found
  end
end
