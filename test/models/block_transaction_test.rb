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
require 'test_helper'

class BlockTransactionTest < ActiveSupport::TestCase
  def setup
    @blockchain = Blockchain.create!(name: Blockchain::NEAR_BLOCKCHAIN_NAME)
    @block = @blockchain.blocks.create!(
      block_id: "block_123",
      height: 1,
      block_hash: SecureRandom.hex(32),
      time: Time.now,
      created_at: Time.now,
      updated_at: Time.now
    )
    @block_transaction = @block.block_transactions.build(
      transaction_hash: SecureRandom.hex(32),
      sender: "sender",
      receiver: "receiver",
      gas_burnt: 1000,
      success: true,
      actions_count: 1
    )
  end

  test "should be valid with all attributes" do
    assert @block_transaction.valid?
  end

  test "should be invalid without transaction_hash" do
    @block_transaction.transaction_hash = nil
    assert_not @block_transaction.valid?
    assert_includes @block_transaction.errors[:transaction_hash], "can't be blank"
  end

  test "should be invalid without sender" do
    @block_transaction.sender = nil
    assert_not @block_transaction.valid?
    assert_includes @block_transaction.errors[:sender], "can't be blank"
  end

  test "should be invalid without receiver" do
    @block_transaction.receiver = nil
    assert_not @block_transaction.valid?
    assert_includes @block_transaction.errors[:receiver], "can't be blank"
  end

  test "should be invalid without gas_burnt" do
    @block_transaction.gas_burnt = nil
    assert_not @block_transaction.valid?
    assert_includes @block_transaction.errors[:gas_burnt], "can't be blank"
  end

  test "should be invalid without success" do
    @block_transaction.success = nil
    assert_not @block_transaction.valid?
    assert_includes @block_transaction.errors[:success], "can't be blank"
  end

  test "should be invalid with a non-unique transaction_hash" do
    duplicate_transaction = @block_transaction.dup
    @block_transaction.save
    assert_not duplicate_transaction.valid?
    assert_includes duplicate_transaction.errors[:transaction_hash], "has already been taken"
  end

  test "should belong to a block" do
    assert_respond_to @block_transaction, :block
  end

  test "should have many actions" do
    assert_respond_to @block_transaction, :actions
  end

  test "should destroy associated actions" do
    @block_transaction.save
    @block_transaction.actions.create!(type: "Transfer", data: { amount: 1000 })

    assert_difference 'Action.count', -1 do
      @block_transaction.destroy
    end
  end
end
