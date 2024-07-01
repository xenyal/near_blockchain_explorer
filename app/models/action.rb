# == Schema Information
#
# Table name: actions
#
#  id                    :bigint           not null, primary key
#  block_transactions_id :bigint           not null
#  type                  :string           not null
#  data                  :json             not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Action < ApplicationRecord
  belongs_to :block_transaction

  validates :type, presence: true
  validates :data, presence: true
end
