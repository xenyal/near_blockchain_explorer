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
require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  def setup
    @blockchain = Blockchain.create!(name: "Test Blockchain")
    @block = @blockchain.blocks.create!(
      block_id: "block_123",
      height: 1,
      block_hash: SecureRandom.hex(32),
      time: Time.now,
      created_at: Time.now,
      updated_at: Time.now
    )
    @block_transaction = @block.block_transactions.create!(
      transaction_hash: SecureRandom.hex(32),
      sender: "sender",
      receiver: "receiver",
      gas_burnt: 1000,
      success: true,
      actions_count: 1
    )
    @action = @block_transaction.actions.build(
      type: "Transfer",
      data: { amount: 1000 }
    )
  end

  test "should be valid with all attributes" do
    assert @action.valid?
  end

  test "should be invalid without type" do
    @action.type = nil
    assert_not @action.valid?
    assert_includes @action.errors[:type], "can't be blank"
  end

  test "should be invalid without data" do
    @action.data = nil
    assert_not @action.valid?
    assert_includes @action.errors[:data], "can't be blank"
  end

  test "should belong to a block_transaction" do
    assert_respond_to @action, :block_transaction
  end
end
