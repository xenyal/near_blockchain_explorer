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
require "test_helper"

class BlockchainTest < ActiveSupport::TestCase
  def setup
    @blockchain = Blockchain.new(name: "Test Blockchain")
  end

  test "should be valid with a name" do
    assert @blockchain.valid?
  end

  test "should be invalid without a name" do
    @blockchain.name = nil
    assert_not @blockchain.valid?
    assert_includes @blockchain.errors[:name], "can't be blank"
  end

  test "should have many blocks" do
    assert_respond_to @blockchain, :blocks
  end

  test "should have many block transactions through blocks" do
    assert_respond_to @blockchain, :block_transactions
  end

  test "should destroy associated blocks" do
    @blockchain.save
    @blockchain.blocks.create!(block_hash: "blockhash1", height: 1, time: Time.now, created_at: Time.now, updated_at: Time.now, block_id: SecureRandom.hex(32))

    assert_difference 'Block.count', -1 do
      @blockchain.destroy
    end
  end

  test "NEAR_BLOCKCHAIN_NAME constant is defined" do
    assert_equal "NEAR", Blockchain::NEAR_BLOCKCHAIN_NAME
  end
end
