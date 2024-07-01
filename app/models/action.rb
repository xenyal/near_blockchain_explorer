# == Schema Information
#
# Table name: actions
#
#  id                   :bigint           not null, primary key
#  block_transaction_id :bigint           not null
#  type                 :string           not null
#  data                 :json             not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Action < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :block_transaction

  validates :type, presence: true
  validates :data, presence: true
end
