# == Schema Information
#
# Table name: blocks
#
#  id            :bigint           not null, primary key
#  blockchain_id :bigint           not null
#  block_id      :string           not null
#  height        :bigint           not null
#  block_hash    :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  time          :datetime         not null
#
class Block < ApplicationRecord
  belongs_to :blockchain
  has_many :block_transactions, dependent: :destroy

  validates :block_hash, presence: true, uniqueness: true
  validates :height, presence: true
  validates :time, presence: true
  validates :block_id, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
end
