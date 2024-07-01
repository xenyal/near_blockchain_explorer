class Api::V1::TransfersController < ApplicationController
  def index
    transfer_transactions = BlockTransaction.joins(:actions)
                                            .where(actions: { type: ::Action::TRANSFER_TYPE })

    render json: Panko::Response.new(data: Panko::ArraySerializer.new(transfer_transactions, each_serializer: TransferSerializer))
  end
end
