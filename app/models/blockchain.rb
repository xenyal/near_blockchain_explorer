# == Schema Information
#
# Table name: blockchains
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  avg_gas_burnt :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Blockchain < ApplicationRecord
  has_many :blocks, dependent: :destroy
  has_many :block_transactions, through: :blocks

  validates :name, presence: true

  NEAR_BLOCKCHAIN_NAME = "NEAR".freeze
end
