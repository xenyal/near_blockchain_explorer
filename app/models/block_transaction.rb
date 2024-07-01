# == Schema Information
#
# Table name: block_transactions
#
#  id               :bigint           not null, primary key
#  block_id         :bigint           not null
#  transaction_hash :string           not null
#  sender           :string           not null
#  receiver         :string           not null
#  gas_burnt        :bigint           not null
#  actions_count    :integer          not null
#  success          :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class BlockTransaction < ApplicationRecord
  belongs_to :block
  has_many :actions, dependent: :destroy

  validates :transaction_hash, presence: true, uniqueness: true
  validates :sender, presence: true
  validates :receiver, presence: true
  validates :gas_burnt, presence: true
  validates :success, inclusion: { in: [true, false] }

  after_create :schedule_avg_gas_burnt_recalculation

  private

  def schedule_avg_gas_burnt_recalculation
    RecalculateAvgGasBurntWorker.perform_async(block.blockchain_id)
  end
end
